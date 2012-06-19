module Rakumarket
  class Client
    attr_accessor :developer_id
    include HTTParty
    base_uri "http://api.rakuten.co.jp/rws/3.0"
    format :json

    def initialize(options={})
      @developer_id = options[:developer_id] || Rakumarket.developer_id
    end

    def request(query={})
      @options = default_options.merge(query).slice(*valid_request_keys)
      transform_request!
      @response = self.class.get("/json",:query => @options)
      respond
    end

private
    def transform_request!
      transform_request_keys!
      transform_request_values!
    end

    def transform_request_keys!
      transform_keys! @options, request_keys_to_transform
    end

    def transform_request_values!
      transform_values! @options, request_values_to_transform
    end

    def respond
      transform_response!
    end

    def transform_response!
      transform_response_values!
      transform_response_keys!
    end

    def transform_response_keys!
      transform_keys! @response, response_keys_to_transform
    end

    def transform_response_values!
      transform_values! @response, response_values_to_transform
    end

    def transform_keys! hash, transformation_index
      transformation_index.each do |k,v|
        hash[v] = hash.delete(k) if hash.has_key?(k)
      end
      hash
    end

    def transform_values! hash, transformation_index
      transformation_index.each do |k,v|
        hash[k] = v[hash[k]] if hash.has_key?(k) && v.has_key?(hash[k])
      end
      hash
    end

    def custom_transform(hash,key)
      yield hash, key if block_given? && hash.has_key?(key)
    end
    def custom_transform!(hash,key)
      hash[key] = yield hash, key if block_given? && hash.has_key?(key)
    end

    def self.get(*args); handle_response super end
    def self.post(*args); handle_response super end

    def self.handle_response(response)
      case response["Header"]["Status"]
      when "Success"; response
      else; raise RakumarketError.new(Hashie::Mash.new(response["Header"].slice("Status","StatusMsg")).rubyify_keys!)
      end

      Hashie::Mash.new(response)

    end
  end
end
