# -*- encoding: utf-8 -*-
module Rakumarket

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

  ITEM_SEARCH_SORT_ORDERS = { 
    "affiliate_rate" => "+affiliateRate",
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
    "updated_at desc" => "-updateTimestamp" 
  }

end