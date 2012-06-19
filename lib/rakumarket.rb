require 'httparty'
require 'hashie'

directory = File.expand_path(File.dirname(__FILE__))

Hash.send :include, Hashie::HashExtensions

module Rakumarket

  def self.item_search(keyword, options={})
    Rakumarket::ItemSearchClient.new.request({:keyword => keyword}.merge(options).hashie_symbolify_keys!)
  end

  def self.genre_search(genre_id=0, options={})
    Rakumarket::GenreSearchClient.new.request({:genre_id => genre_id}.merge(options).hashie_symbolify_keys!)
  end

  #def self.item_code_search(item_code, options={})
  #  Rakumarket::ItemCodeSearchClient.new.request({:item_code => item_code}.merge(options).hashie_symbolify_keys!)
  #end


  class << self
    attr_accessor :developer_id
  end

  # Contains information for errors returned by the API
  class RakumarketError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super data.status_msg
    end
  end
end

class String
  def blank?
    self !~ /[^[:space:]]/
  end
  def present?
    !blank?
  end
end

class Hash
  def slice(*keys)
    keys.map! { |key| convert_key(key) } if respond_to?(:convert_key, true)
    keys.each_with_object(self.class.new) { |k, hash| hash[k] = self[k] if has_key?(k) }
  end
end

module Hashie::HashExtensions
  # Destructively convert all of the keys of a Hash
  # to their symbol representations.
  def hashie_symbolify_keys!
    self.keys.each do |k|
      unless Symbol === k
        self[k.to_sym] = self.delete(k)
      end
    end
    self
  end
end

require File.join(directory, 'rakumarket', 'client')
require File.join(directory, 'rakumarket', 'item_search_client')
require File.join(directory, 'rakumarket', 'genre_search_client')
