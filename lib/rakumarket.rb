require 'httparty'
require 'nibbler/json'

directory = File.expand_path(File.dirname(__FILE__))

module Rakumarket

  def self.item_search(keyword, params={})
    params = {:keyword => keyword}.merge(params).symbolify_keys!
    ItemSearchClient.request(params)
  end

  def self.genre_search(genre_id=0, options={})
    params = {:genre_id => genre_id}.merge(options).symbolify_keys!
    GenreSearchClient.request(params)
  end

  def self.item_lookup(item_code, options={})
    params = {:code => item_code}.merge(options).symbolify_keys!
    ItemLookupClient.request(params)
  end


  class << self
    attr_accessor :developer_id
  end

  # Contains information for errors returned by the API
  class RakumarketError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super data[:status_msg]
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
    keys.inject(self.class.new) { |hash, k| hash[k] = self[k] if has_key?(k); hash }
  end

  def symbolify_keys!
    self.keys.each do |k|
      unless Symbol === k
        self[k.to_sym] = self.delete(k)
      end
    end
    self
  end
end

require File.join(directory, 'rakumarket', 'constants')
require File.join(directory, 'rakumarket', 'spitter')
require File.join(directory, 'rakumarket', 'models')
require File.join(directory, 'rakumarket', 'client')
