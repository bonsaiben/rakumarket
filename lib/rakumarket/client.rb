# -*- encoding: utf-8 -*-
module Rakumarket
  class Client < Spitter
    attr_accessor :developer_id
    include HTTParty
    base_uri "http://api.rakuten.co.jp/rws/3.0"
    format :json

    parameter :developer_id => 'developerId'

    def self.request(params) new(params).request end

    def initialize(params={})
      @developer_id = params[:developer_id] || Rakumarket.developer_id
      super params.merge(default_options)
    end

    def request
      @response = self.class.get("/json", :query => parse)
    end

private
    def default_options 
      { :developer_id => @developer_id,
        :operation => nil, 
        :version => nil }
    end

    def self.get(*args); handle_response super end
    def self.post(*args); handle_response super end

    def self.handle_response(response)
      case response["Header"]["Status"]
      when "Success"; response
      else; raise RakumarketError.new({:status => response["Header"]["Status"], :status_msg => response["Header"]["StatusMsg"]})
      end
      response
    end
  end

  class TrueToOne
    def self.parse value
      value ? "1" : "0"
    end
  end

  class TrueToZero
    def self.parse value
      value ? "0" : "1"
    end
  end

  class ItemSearchClient < Client

    OPERATION = "ItemSearch"
    VERSION = "2010-09-15"

    class SortOrder
      def self.parse(value) ITEM_SEARCH_SORT_ORDERS[value.downcase] end
    end

    class CountryCode
      def self.parse(value) INTERNATIONAL_DELIVERY_AREA_CODES[value] end
    end

    class NextDayAreaCode
      def self.parse(value) ASURAKU_DELIVERY_AREA_CODES[value] end
    end

    class PurchaseType
      def self.parse(value)
        {"normal" => 0, "regular" => 1, "distribution" => 2}[value]
      end
    end

    parameter :operation, :with => lambda { OPERATION }
    parameter :version, :with => lambda { VERSION }
    parameter :keyword
    parameter :page
    parameters :price do
      parameter :minimum => 'minPrice'
      parameter :maximum => 'maxPrice'
    end
    parameters :shipping do
      parameter :must_ship_international => 'shipOverseasFlag', :with => TrueToOne
      parameter :country => 'shipOverseasArea', :with => CountryCode
      parameter :must_ship_next_day => 'asurakuFlag', :with => TrueToOne
      parameter :next_day_area => 'asurakuArea', :with => NextDayAreaCode
      parameter :must_include_cost => 'postageFlag', :with => TrueToOne
    end
    parameter :affiliate_id => 'affiliateId'
    parameter :call_back => 'callBack'
    parameter :items_per_page => 'hits'
    parameter :shop_code => 'shopCode'
    parameter :genre_id => 'genreId'
    parameter :order => 'sort', :with => SortOrder
    parameter :must_be_available => 'availability', :with => TrueToOne
    parameter :deep_search => 'field', :with => TrueToZero
    parameter :mobile => 'carrier', :with => TrueToOne
    parameter :must_have_image => 'imageFlag', :with => TrueToOne
    parameter :or_search => 'orFlag', :with => TrueToOne
    parameter :exclude_keyword => 'NGKeyword'
    parameter :include_genre_info => 'genreInformationFlag', :with => TrueToOne
    parameter :purchase_type => 'purchaseType', :with => PurchaseType
    parameter :must_have_point_multiplication => 'pointRateFlag', :with => TrueToOne
    parameter :point_multiplication_factor => 'pointRate'
    parameter :must_accept_credit_cards => 'creditCardFlag', :with => TrueToOne

    def request
      response = super
      ItemList.parse(response)
    end

  end

  class GenreSearchClient < Client

    OPERATION = "GenreSearch"
    VERSION = "2007-04-11"

    parameter :operation, :with => lambda { OPERATION }
    parameter :version, :with => lambda { VERSION }
    parameter :genre_id => 'genreId'
    parameter :return_immediate_parent => 'genrePath', :with => TrueToZero

    def request
      response = super
      Genre.parse(response)
    end

  end

  class ItemLookupClient < Client
    OPERATION = "ItemCodeSearch"
    VERSION = "2010-08-05"

    parameter :operation, :with => lambda { OPERATION }
    parameter :version, :with => lambda { VERSION }
    parameter :code => 'itemCode'
    parameter :mobile => 'carrier', :with => TrueToOne

    def request
      response = super
      Item.parse(response)
    end
  end

end
