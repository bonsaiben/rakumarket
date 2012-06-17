require 'httparty'
require 'hashie'
require 'active_support'

directory = File.expand_path(File.dirname(__FILE__))

Hash.send :include, Hashie::HashExtensions

module Rakumarket

  def self.item_search(keyword, options={})
    Rakumarket::ItemSearchClient.new.request({:keyword => keyword}.merge(options).hashie_symbolify_keys!)
  end

  #def self.genre_search(genre_id, options={})
  #  Rakumarket::GenreSearchClient.new.request({:genre_id => genre_id}.merge(options).hashie_symbolify_keys!)
  #end

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

class Hashie::Mash
  # Converts all of the keys to strings, optionally formatting key name
  def rubyify_keys!
    keys.each{|k|
      v = delete(k)
      regular_writer(k.to_s.underscore, v)
      v.rubyify_keys! if v.is_a?(Hash)
      v.each{|p| p.rubyify_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
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
require File.join(directory, 'rakumarket', 'item_code_search_client')
