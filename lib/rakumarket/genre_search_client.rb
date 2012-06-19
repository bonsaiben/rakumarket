module Rakumarket
  class GenreSearchClient < Client

    OPERATION = "GenreSearch"
    VERSION = "2007-04-11"

    VALID_REQUEST_KEYS = [
      :developer_id,
      :affiliate_id,
      :operation,
      :call_back,
      :genre_id,
      :version,
      :return_immediate_parent
    ]

    REQUEST_KEYS_TO_TRANSFORM = {
      :developer_id => :developerId,
      :affiliate_id => :affiliateId,
      :call_back => :callBack,
      :genre_id => :genreId,
      :return_immediate_parent => :genrePath
    }

    REQUEST_VALUES_TO_TRANSFORM = {
      :genrePath => {false => 1, true => 0}
    }

    RESPONSE_GENRE_KEYS_TO_TRANSFORM = {
      :genreId => :genre_id,
      :genreName => :genre_name,
      :itemCount => :item_count,
      :genreLevel => :genre_level
    }

private
    def respond
      @response = @response['Body']['GenreSearch']
      super
    end

    def default_options
      { :developer_id => @developer_id, 
        :operation => OPERATION, 
        :version => VERSION }
    end

    def transform_response_values!
      custom_transform!(@response, 'parent'){|h,k| h[k].first }
      custom_transform!(@response, 'current'){|h,k| h[k].first }
      super
    end

    def transform_response_keys!
      custom_transform(@response,'child'){|h,k| h[:children] = h.delete(k) }
      @response['children'].each do |child|
        transform_keys! child, RESPONSE_GENRE_KEYS_TO_TRANSFORM
      end
      transform_keys! @response['parent'], RESPONSE_GENRE_KEYS_TO_TRANSFORM if @response['parent']
      transform_keys! @response['current'], RESPONSE_GENRE_KEYS_TO_TRANSFORM if @response['current']
      super
    end

    def valid_request_keys
      VALID_REQUEST_KEYS
    end

    def request_keys_to_transform
      REQUEST_KEYS_TO_TRANSFORM
    end

    def request_values_to_transform
      REQUEST_VALUES_TO_TRANSFORM
    end

  end
end
