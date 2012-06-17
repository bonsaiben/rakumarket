# -*- encoding: utf-8 -*-
module Rakumarket
  class ItemSearchClient < Client

    OPERATION = "ItemSearch"
    VERSION = "2010-09-15"

    INTERNATIONAL_DELIVERY_AREA_CODES = {
      "worldwide" => "ALL",
      "usa" => "US",
      "argentina" => "AR",
      "brazil" => "BR",
      "canada" => "CA",
      "mexico" => "MX",
      "austria" => "AT",
      "belgium" => "BE",
      "denmark" => "DK",
      "france" => "FR",
      "germany" => "DE",
      "greece" => "GR",
      "italy" => "IT",
      "morocco" => "MA",
      "netherlands" => "NL",
      "poland" => "PL",
      "portugal" => "PT",
      "russia" => "RU",
      "spain" => "ES",
      "sweden" => "SE",
      "switzerland" => "CH",
      "turkey" => "TR",
      "england" => "GB",
      "australia" => "AU",
      "china" => "CN",
      "hong kong" => "HK",
      "india" => "IN",
      "indonesia" => "ID",
      "south korea" => "KR",
      "malaysia" => "MY",
      "new zealand" => "NZ",
      "philipines" => "PH",
      "singapore" => "SG",
      "taiwan" => "TW",
      "thailand" => "TH",
      "vietnam" => "VN"
    }

    INTERNATIONAL_DELIVERY_AREA_NAMES = {
      "ワールドワイド" => "worldwide",
      "アメリカ" => "usa",
      "アルゼンチン" => "argentina",
      "ブラジル" => "brazil",
      "カナダ" => "canada",
      "メキシコ" => "mexico",
      "オーストリア" => "austria",
      "ベルギー" => "belgium",
      "デンマーク" => "denmark",
      "フランス" => "france",
      "ドイツ" => "germany",
      "ギリシャ" => "greece",
      "イタリア" => "italy",
      "モロッコ" => "morocco",
      "オランダ" => "netherlands",
      "ポーランド" => "poland",
      "ポルトガル" => "portugal",
      "ロシア" => "russia",
      "スペイン" => "spain",
      "スウェーデン" => "sweden",
      "スイス" => "switzerland",
      "トルコ" => "turkey",
      "英国" => "england",
      "オーストラリア" => "australia",
      "中国" => "china",
      "香港" => "hong kong",
      "インド" => "india",
      "インドネシア" => "indonesia",
      "韓国" => "south korea",
      "マレーシア" => "malaysia",
      "ニュージーランド" => "new zealand",
      "フィリピン" => "philipines",
      "シンガポール" => "singapore",
      "台湾" => "taiwan",
      "タイ" => "thailand",
      "ベトナム" => "vietnam",
    }

    ASURAKU_DELIVERY_AREA_CODES = {
      "all" => "0",
      "hokkaido" => "1",
      "tohoku" => "101",
      "aomori" => "2",
      "iwate" => "3",
      "miyagi" => "4",
      "akita" => "5",
      "yamagata" => "6",
      "fukushima" => "7",
      "kanto" => "102",
      "ibaraki" => "8",
      "tochigi" => "9",
      "gunma" => "10",
      "saitama" => "11",
      "chiba" => "12",
      "tokyo" => "13",
      "kanagawa" => "14",
      "koshinetsu" => "103",
      "niigata" => "15",
      "yamanashi" => "19",
      "nagano" => "20",
      "hokuriku" => "104",
      "toyama" => "16",
      "ishikawa" => "17",
      "fukui" => "18",
      "tokai" => "105",
      "gifu" => "21",
      "shizuoka" => "22",
      "aichi" => "23",
      "mie" => "24",
      "kansai" => "106",
      "shiga" => "25",
      "kyoto" => "26",
      "osaka" => "27",
      "hyogo" => "28",
      "nara" => "29",
      "wakayama" => "30",
      "chugoku" => "107",
      "tottori" => "31",
      "shimane" => "32",
      "okayama" => "33",
      "hiroshima" => "34",
      "yamaguchi" => "35",
      "shikoku" => "108",
      "tokushima" => "36",
      "kagawa" => "37",
      "ehime" => "38",
      "kochi" => "39",
      "kyushu" => "109",
      "fukuoka" => "40",
      "saga" => "41",
      "nagasaki" => "42",
      "kumamoto" => "43",
      "ooita" => "44",
      "miyaza" => "45",
      "kagoshima" => "46",
      "okinawa" => "47"
    }

    ASURAKU_DELIVERY_AREA_NAMES = {
      "全地域" => "all",
      "北海道エリアのすべて" => "hokkaido",
      "北海道" => "hokkaido",
      "東北エリアのすべて" => "tohoku",
      "青森県" => "aomori",
      "岩手県" => "iwate",
      "宮城県" => "miyagi",
      "秋田県" => "akita",
      "山形県" => "yamagata",
      "福島県" => "fukushima",
      "関東エリアのすべて" => "kanto",
      "茨城県" => "ibaraki",
      "栃木県" => "tochigi",
      "群馬県" => "gunma",
      "埼玉県" => "saitama",
      "千葉県" => "chiba",
      "東京都" => "tokyo",
      "神奈川県" => "kanagawa",
      "甲信越エリアのすべて" => "koshinetsu",
      "新潟県" => "niigata",
      "山梨県" => "yamanashi",
      "長野県" => "nagano",
      "北陸エリアのすべて" => "hokuriku",
      "富山県" => "toyama",
      "石川県" => "ishikawa",
      "福井県" => "fukui",
      "東海エリアのすべて" => "tokai",
      "岐阜県" => "gifu",
      "静岡県" => "shizuoka",
      "愛知県" => "aichi",
      "三重県" => "mie",
      "関西エリアのすべて" => "kansai",
      "滋賀県" => "shiga",
      "京都府" => "kyoto",
      "大阪府" => "osaka",
      "兵庫県" => "hyogo",
      "奈良県" => "nara",
      "和歌山県" => "wakayama",
      "中国エリアのすべて" => "chugoku",
      "鳥取県" => "tottori",
      "島根県" => "shimane",
      "岡山県" => "okayama",
      "広島県" => "hiroshima",
      "山口県" => "yamaguchi",
      "四国エリアのすべて" => "shikoku",
      "徳島県" => "tokushima",
      "香川県" => "kagawa",
      "愛媛県" => "ehime",
      "高知県" => "kochi",
      "九州エリアのすべて" => "kyushu",
      "福岡県" => "fukuoka",
      "佐賀県" => "saga",
      "長崎県" => "nagasaki",
      "熊本県" => "kumamoto",
      "大分県" => "ooita",
      "宮崎県" => "miyaza",
      "鹿児島県" => "kagoshima",
      "沖縄エリアのすべて" => "okinawa",
      "沖縄県" => "okinawa"
    }

    VALID_REQUEST_KEYS = [
      :developer_id,
      :affiliate_id,
      :operation,
      :call_back,
      :keyword,
      :version,
      :shop_code,
      :genre_id,
      :items_per_page,
      :page,
      :order,
      :price,
      :available,
      :deep_search,
      :mobile,
      :image,
      :or_search,
      :exclude_keyword,
      :include_genre_info,
      :purchase_type,
      :shipping,
      :point_multiplication,
      :point_multiplication_factor,
      :credit_cards_accepted
    ]

    REQUEST_KEYS_TO_TRANSFORM = {
      :developer_id => :developerId,
      :affiliate_id => :affiliateId,
      :call_back => :callBack,
      :items_per_page => :hits,
      :shop_code => :shopCode,
      :genre_id => :genreId,
      :order => :sort,
      :available => :availability,
      :deep_search => :field,
      :mobile => :carrier,
      :has_image => :imageFlag,
      :or_search => :orFlag,
      :exclude_keyword => :NGKeyword,
      :include_genre_info => :genreInformationFlag,
      :purchase_type => :purchaseType,
      :point_multiplication => :pointRateFlag,
      :point_multiplication_factor => :pointRate,
      :credit_cards_accepted => :creditCardFlag
    }

    REQUEST_VALUES_TO_TRANSFORM = {
      :availability => {true => 1, false => 0},
      :field => {true => 0, false => 1},
      :sort => {  "affiliate_rate" => "+affiliateRate",
                  "affiliate_rate asc" => "+affiliateRate",
                  "affiliate_rate desc" => "-affiliateRate",
                  "review_count" => "+reviewCount",
                  "review_count asc" => "+reviewCount",
                  "review_count desc" => "-reviewCount",
                  "review_average" => "+reviewAverage",
                  "review_average asc" => "+reviewAverage",
                  "review_average desc" => "-reviewAverage",
                  "price" => "+itemPrice",
                  "price asc" => "+itemPrice",
                  "price desc" => "-itemPrice",
                  "updated_at" => "+updateTimestamp",
                  "updated_at asc" => "+updateTimestamp",
                  "updated_at desc" => "-updateTimestamp" },
      :carrier => {true => 1, false => 0},
      :imageFlag => {true => 1, false => 0},
      :orFlag => {true => 1, false => 0},
      :genreInformationFlag => {true => 1, false => 0},
      :purchaseType => {"normal" => 0, "regular" => 1, "distribution" => 2},
      :shipOverseasFlag => {false => 0, true => 1},
      :shipOverseasArea => INTERNATIONAL_DELIVERY_AREA_CODES,
      :asurakuFlag => {false => 0, true => 1},
      :asurakuArea => ASURAKU_DELIVERY_AREA_CODES,
      :pointRateFlag => {false => 0, true => 1},
      :postageFlag => {false => 0, true => 1},
      :creditCardFlag => {false => 0, true => 1}
    }

    RESPONSE_VALUES_TO_TRANSFORM = {
      'carrier' => {0 => false, 1 => true},
    }

    RESPONSE_ITEM_VALUES_TO_TRANSFORM = {
      'imageFlag' => {0 => false, 1 => true},
      'availability' => {0 => false, 1 => true},
      'taxFlag' => {0 => true, 1 => false},
      'postageFlag' => {0 => true, 1 => false},
      'creditCardFlag' => {0 => false, 1 => true},
      'shopOfTheYearFlag' => {1 => true},
      'shipOverseasFlag' => {0 => false, 1 => true},
      'asurakuFlag' => {0 => false, 1 => true}
    }

    RESPONSE_KEYS_TO_TRANSFORM = {
      :developerId => :developer_id,
      :affiliateId => :affiliate_id,
      :Status => :status,
      :StatusMsg => :status_msg,
      :first => :first_page,
      :last => :last_page,
      :hits => :items_per_page,
      :carrier => :mobile?,
      :pageCount => :page_count,
      :Items => :items,
      :genreInformation => :genre_info
    }

    RESPONSE_ITEM_KEYS_TO_TRANSFORM = {
      :itemName => :name,
      :itemCode => :code,
      :itemPrice => :price,
      :itemCaption => :caption,
      :itemUrl => :url,
      :affiliateUrl => :affiliate_url,
      :imageFlag => :has_image?,
      :smallImageUrl => :small_image_url,
      :mediumImageUrl => :medium_image_url,
      :availability => :available?,
      :taxFlag => :tax_included?,
      :creditCardFlag => :credit_cards_accepted?,
      :shopOfTheYearFlag => :shop_of_the_year?,
      :affiliateRate => :affiliate_rate,
      :startTime => :start_time,
      :endTime => :end_time,
      :reviewCount => :review_count,
      :reviewAverage => :review_average,
      :pointRate => :point_multiplication_factor,
      :pointRateStartTime => :point_multiplication_start_time,
      :pointRateEndTime => :point_multiplication_end_time,
      :genreId => :genre_id
    }

    RESPONSE_GENRE_INFO_KEYS_TO_TRANSFORM = {
      :genreId => :genre_id,
      :genreName => :genre_name,
      :itemCount => :item_count,
      :genreLevel => :genre_level
    }

private
    def respond
      @response = @response['Body']['ItemSearch']
      super
    end

    def transform_request_keys!
      if price = @options.delete(:price)
        @options[:minPrice] = price[:minimum] if price[:minimum]
        @options[:maxPrice] = price[:maximum] if price[:maximum]
      end
      if shipping = @options.delete(:shipping)
        @options[:shipOverseasFlag] = shipping[:international] if shipping[:international]
        @options[:shipOverseasArea] = shipping[:country] if shipping[:country]
        @options[:asurakuFlag] = shipping[:next_day] if shipping[:next_day]
        @options[:asurakuArea] = shipping[:next_day_area] if shipping[:next_day_area]
        @options[:postageFlag] = shipping[:cost_included] if shipping[:cost_included]
      end
      @options[:order].downcase! if @options[:order].is_a?(String)
      super
    end

    def transform_response_values!
      transform_response_item_values!
      transform_response_genre_info_values! if @response.has_key?('genreInformation')
      super
    end

    def transform_response_item_values!
      @response['Items'] = @response['Items']['Item'].is_a?(Array) ? @response['Items']['Item'] : []
      @response['Items'].each do |item|
        custom_transform!(item,'shipOverseasArea'){|h,k| h[k].split('/').map{|a| INTERNATIONAL_DELIVERY_AREA_NAMES[a] || a } if h[k].is_a?(String) }
        custom_transform!(item,'asurakuArea'){|h,k| h[k].split('/').map{|a| ASURAKU_DELIVERY_AREA_NAMES[a] || a} if h[k].is_a?(String) }
        custom_transform!(item, 'startTime'){|h,k| Time.parse(h[k]) if h[k].present? }
        custom_transform!(item, 'endTime'){|h,k| Time.parse(h[k]) if h[k].present? }
        custom_transform!(item, 'pointRateStartTime'){|h,k| Time.parse(h[k]) if h[k].present? }
        custom_transform!(item, 'pointRateEndTime'){|h,k| Time.parse(h[k]) if h[k].present? }
        transform_values! item, RESPONSE_ITEM_VALUES_TO_TRANSFORM
      end
    end

    def transform_response_genre_info_values!
      genre_info = @response['genreInformation']
      custom_transform!(genre_info, 'parent'){|h,k| h[k].first }
      custom_transform!(genre_info, 'current'){|h,k| h[k].first }
    end

    def transform_response_keys!
      transform_response_item_keys!
      transform_response_genre_info_keys! if @response.has_key?('genreInformation')
      super
    end

    def transform_response_item_keys!
      @response['Items'].each do |item|
        item[:shipping] = {}
        custom_transform(item,'postageFlag'){|h,k| h[:shipping][:cost_included?] = h.delete(k) }
        custom_transform(item,'shipOverseasFlag'){|h,k| h[:shipping][:international?] = h.delete(k) }
        custom_transform(item,'shipOverseasArea'){|h,k| h[:shipping][:countries] = h.delete(k) }
        custom_transform(item,'asurakuFlag'){|h,k| h[:shipping][:next_day?] = h.delete(k) }
        custom_transform(item,'asurakuArea'){|h,k| h[:shipping][:next_day_areas] = h.delete(k) }
        item[:shop] = {}
        custom_transform(item,'shopName'){|h,k| h[:shop][:name] = h.delete(k) }
        custom_transform(item,'shopCode'){|h,k| h[:shop][:code] = h.delete(k) }
        custom_transform(item,'shopUrl'){|h,k| h[:shop][:url] = h.delete(k) }
        transform_keys! item, RESPONSE_ITEM_KEYS_TO_TRANSFORM
      end
    end

    def transform_response_genre_info_keys!
      genre_info = @response['genreInformation']
      custom_transform(genre_info,'child'){|h,k| h[:children] = h.delete(k) }
      genre_info['children'].each do |child|
        transform_keys! child, RESPONSE_GENRE_INFO_KEYS_TO_TRANSFORM
      end
      transform_keys! genre_info['parent'], RESPONSE_GENRE_INFO_KEYS_TO_TRANSFORM if genre_info['parent']
      transform_keys! genre_info['current'], RESPONSE_GENRE_INFO_KEYS_TO_TRANSFORM if genre_info['current']
    end

    def default_options
      { :developer_id => @developer_id, 
        :operation => OPERATION, 
        :version => VERSION }
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

    def response_keys_to_transform
      RESPONSE_KEYS_TO_TRANSFORM
    end

    def response_values_to_transform
      RESPONSE_VALUES_TO_TRANSFORM
    end

  end
end
