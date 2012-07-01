# -*- encoding: utf-8 -*-

module Rakumarket
  class Base < NibblerJSON
  end

  class OneToTrue
    def self.parse(val) {"1" => true, "0" => false}[val.to_s] end
  end

  class ZeroToTrue
    def self.parse(val) {"0" => true, "1" => false}[val.to_s] end
  end

  class ParseTime < Time
    def self.parse(val) super unless val.blank? end
  end

  class InternationalDeliveryCountryList
    def self.parse(val)
      val.split('/').map{|a| INTERNATIONAL_DELIVERY_AREA_NAMES[a] || a} if val.respond_to?(:split)
    end
  end

  class NextDayAreaList
    def self.parse(val)
      val.split('/').map{|a| ASURAKU_DELIVERY_AREA_NAMES[a] || a} if val.respond_to?(:split)
    end
  end

  class Shipping < Base
    element 'postageFlag' => :cost_included, :with => ZeroToTrue
    element 'shipOverseasFlag' => :international, :with => OneToTrue
    element 'shipOverseasArea' => :countries, :with => InternationalDeliveryCountryList
    element 'asurakuFlag' => :next_day, :with => OneToTrue
    element 'asurakuArea' => :next_day_areas, :with => NextDayAreaList

    def cost_included?; cost_included end
    def international?; international end
    def next_day?; next_day end
  end

  class Item < Base
    element 'itemName' => :name
    element 'catchcopy' => :catchphrase
    element 'itemCode' => :code
    element 'itemPrice' => :price
    element 'itemCaption' => :caption
    element 'itemUrl' => :url
    element 'genreId' => :genre_id
    element 'affiliateUrl' => :affiliate_url
    element 'imageFlag' => :has_image, :with => OneToTrue
    element 'smallImageUrl' => :small_image_url
    element 'mediumImageUrl' => :medium_image_url
    element 'availability' => :available, :with => OneToTrue
    element 'taxFlag' => :tax_included, :with => ZeroToTrue
    element 'creditCardFlag' => :credit_cards_accepted, :with => OneToTrue
    element 'shopOfTheYearFlag' => :shop_of_the_year, :with => OneToTrue
    element 'affiliateRate' => :affiliate_rate
    element 'startTime' => :start_time, :with => ParseTime
    element 'endTime' => :end_time, :with => ParseTime
    element 'reviewCount' => :review_count
    element 'reviewAverage' => :review_average
    element 'pointRate' => :point_multiplication_factor
    element 'pointRateStartTime' => :point_multiplication_start_time, :with => ParseTime
    element 'pointRateEndTime' => :point_multiplication_end_time, :with => ParseTime
    element :shop do
      element 'shopName' => :name
      element 'shopCode' => :code
      element 'shopUrl' => :url
    end
    element :shipping, :with => Shipping

    def has_image?; has_image end
    def available?; available end
    def tax_included?; tax_included end
    def credit_cards_accepted?; credit_cards_accepted end
    def shop_of_the_year?; shop_of_the_year end

    def self.parse(response)
      response['shop'] = {
        'shopName' => response.delete('shopName'),
        'shopCode' => response.delete('shopCode'),
        'shopUrl' => response.delete('shopUrl')
      }
      response['shipping'] = {
        'postageFlag' => response.delete('postageFlag'),
        'shipOverseasFlag' => response.delete('shipOverseasFlag'),
        'shipOverseasArea' => response.delete('shipOverseasArea'),
        'asurakuFlag' => response.delete('asurakuFlag'),
        'asurakuArea' => response.delete('asurakuArea')
      }
      super(response)
    end
  end

  class ItemList < Base
    element 'count' => :total_item_count
    element 'pageCount' => :page_count
    element :page
    elements :items, :with => Item

    def self.parse(response)
      response['items'] = response.delete('Items')['Item']
      super(response)
    end
  end

  class Genre < Base
    element 'genreId' => :id
    element 'genreName' => :name
    element :parent, :with => Genre
    elements 'child' => :children, :with => Genre

    def self.parse(response)
      response['genreId'] = response['current'].first['genreId'] if response['current'] && response['current'].any?
      response['genreName'] = response['current'].first['genreName'] if response['current'] && response['current'].any?
      super(response)
    end
  end

end
