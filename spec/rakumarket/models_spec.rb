# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Rakumarket::ItemList do
  describe "#parse" do
    before do
      @response = {"Items" => {"Item" => [{"shopOfTheYearFlag" => "0", "pointRate" => "2", "affiliateRate" => "435", "shipOverseasFlag" => "1", "asurakuFlag" => "1", "endTime" => "2012-02-05 14:23", "taxFlag" => "1", "startTime" => "2000-01-01 12:00", "itemCaption" => "thecaption", "catchcopy" => "great item", "mediumImageUrl" => "themediumimage", "imageFlag" => "0", "availability" => "0", "itemCode" => "abc123", "postageFlag" => "0", "itemName" => "Roomba", "smallImageUrl" => "thesmallimage", "itemPrice" => "2000", "pointRateEndTime" => "1999-12-30 09:01", "shopCode" => "theshopcode", "affiliateUrl" => "theaffiliateurl", "shopName" => "theshopname", "asurakuArea" => "神奈川県/滋賀県", "reviewCount" => "3", "shopUrl" => "theshopurl", "creditCardFlag" => "0", "reviewAverage" => "4", "shipOverseasArea" => "フランス/イタリア", "genreId" => "23", "pointRateStartTime" => "2007-03-03 03:33", "itemUrl" => "theurl"}]}, "pageCount" => 100, "hits" => 30, "last" => 30, "count" => 3507, "page" => 1, "carrier" => 0, "first" => 1}
      @item_list = Rakumarket::ItemList.parse(@response)
    end

    it "should parse item_count" do
      @item_list.total_item_count.should eq(3507)
    end

    it "should parse page_count" do
      @item_list.page_count.should eq(100)
    end

    it "should parse page" do
      @item_list.page.should eq(1)
    end

    it "should parse items" do
      @item_list.items.should be_a(Array)
    end

    describe "items" do
      it "should contain a list of items" do
        items = @item_list.items
        items.first.should be_a(Rakumarket::Item)
      end

      describe "item" do
        before do
          @item = @item_list.items.first
        end

        it "should parse name" do
          @item.name.should eq("Roomba")
        end

        it "should parse catchphrase" do
          @item.catchphrase.should eq("great item")
        end

        it "should parse code" do
          @item.code.should eq("abc123")
        end

        it "should parse price" do
          @item.price.should eq('2000')
        end

        it "should parse caption" do
          @item.caption.should eq("thecaption")
        end

        it "should parse url" do
          @item.url.should eq("theurl")
        end

        it "should parse genre_id" do
          @item.genre_id.should eq('23')
        end

        describe "shop" do
          it "should parse shop name" do
            @item.shop.name.should eq("theshopname")
          end

          it "should parse shop code" do
            @item.shop.code.should eq("theshopcode")
          end

          it "should parse shop url" do
            @item.shop.url.should eq("theshopurl")
          end
        end

        describe "shipping" do
          it "should parse cost_included?" do
            @item.shipping.cost_included?.should be_true
          end

          it "should parse cost_included? false" do
            @response = {"Items" => {"Item" => [{"postageFlag" => "1"}]}}
            @item = Rakumarket::ItemList.parse(@response).items.first
            @item.shipping.cost_included?.should be_false
          end

          it "should parse international?" do
            @item.shipping.international?.should be_true
          end

          it "should parse international? false" do
            @response = {"Items" => {"Item" => [{"shipOverseasFlag" => "0"}]}}
            @item = Rakumarket::ItemList.parse(@response).items.first
            @item.shipping.international?.should be_false
          end

          it "should parse international? numeric true" do
            @response = {"Items" => {"Item" => [{"shipOverseasFlag" => 1}]}}
            @item = Rakumarket::ItemList.parse(@response).items.first
            @item.shipping.international?.should be_true
          end

          it "should parse countries" do
            @item.shipping.countries.should eq(["france","italy"])
          end

          it "should parse next_day?" do
            @item.shipping.next_day?.should be_true
          end

          it "should parse next_day? false" do
            @response = {"Items" => {"Item" => [{"asurakuFlag" => "0"}]}}
            @item = Rakumarket::ItemList.parse(@response).items.first
            @item.shipping.next_day?.should be_false
          end

          it "should parse next_day_areas" do
            @item.shipping.next_day_areas.should eq(["kanagawa","shiga"])
          end
        end

        it "should parse affiliate_url" do
          @item.affiliate_url.should eq("theaffiliateurl")
        end

        it "should parse has_image?" do
          @item.has_image?.should be_false
        end

        it "should parse small_image_url" do
          @item.small_image_url.should eq("thesmallimage")
        end

        it "should parse medium_image_url" do
          @item.medium_image_url.should eq("themediumimage")
        end

        it "should parse available?" do
          @item.available?.should be_false
        end

        it "should parse tax_included?" do
          @item.tax_included?.should be_false
        end

        it "should parse credit_cards_accepted?" do
          @item.credit_cards_accepted?.should be_false
        end

        it "should parse shop_of_the_year?" do
          @item.shop_of_the_year?.should be_false
        end

        it "should parse shop_of_the_year? true" do
          @response = {"Items" => {"Item" => [{"shopOfTheYearFlag" => "1"}]}}
          @item = Rakumarket::ItemList.parse(@response).items.first
          @item.shop_of_the_year?.should be_true
        end

        it "should parse affiliate_rate" do
          @item.affiliate_rate.should eq('435')
        end

        it "should parse start_time" do
          @item.start_time.should be_a(Time)
        end

        it "should parse start_time as nil if blank" do
          @response = {"Items" => {"Item" => [{"startTime" => ""}]}}
          @item = Rakumarket::ItemList.parse(@response).items.first
          @item.start_time.should be_nil
        end

        it "should parse end_time" do
          @item.end_time.should be_a(Time)
        end

        it "should parse end_time as nil if blank" do
          @response = {"Items" => {"Item" => [{"endTime" => ""}]}}
          @item = Rakumarket::ItemList.parse(@response).items.first
          @item.end_time.should be_nil
        end

        it "should parse review_count" do
          @item.review_count.should eq("3")
        end

        it "should parse review_average" do
          @item.review_average.should eq("4")
        end

        it "should parse point_multiplication_factor" do
          @item.point_multiplication_factor.should eq("2")
        end

        it "should parse point_multiplication_start_time" do
          @item.point_multiplication_start_time.should be_a(Time)
        end

        it "should parse point_multiplication_end_time" do
          @item.point_multiplication_end_time.should be_a(Time)
        end
      end
    end

  end
end

describe Rakumarket::ItemList do
  describe "#parse" do
    context "root" do
      before do
        @response = {"child" => [{"genreLevel" => 1,"genreName" => "CD・DVD・楽器","genreId" => 101240},{"genreLevel" => 1,"genreName" => "インテリア・寝具・収納","genreId" => 100804},{"genreLevel" => 1,"genreName" => "おもちゃ・ホビー・ゲーム","genreId" => 101164},{"genreLevel" => 1,"genreName" => "キッズ・ベビー・マタニティ","genreId" => 100533},{"genreLevel" => 1,"genreName" => " 日用品雑貨・文房具・手芸","genreId" => 215783},{"genreLevel" => 1,"genreName" => "ジュエリー・アクセサリー","genreId" => 216129},{"genreLevel" => 1,"genreName" => "スポーツ・アウトドア","genreId" => 101070},{"genreLevel" => 1,"genreName" => "ダイエット・健康","genreId" => 100938},{"genreLevel" => 1,"genreName" => "水・ソフトドリンク","genreId" => 100316},{"genreLevel" => 1,"genreName" => "パソコン・周辺機器","genreId" => 100026},{"genreLevel" => 1,"genreName" => "バッグ・小物・ブランド雑貨","genreId" => 216131},{"genreLevel" => 1,"genreName" => "レディースファッション","genreId" => 100371},{"genreLevel" => 1,"genreName" => "花・ガーデン・DIY","genreId" => 100005},{"genreLevel" => 1,"genreName" => "ペット・ペットグッズ","genreId" => 101213},{"genreLevel" => 1,"genreName" => "TV・オーディオ・カメラ","genreId" => 211742},{"genreLevel" => 1,"genreName" => "車・バイク","genreId" => 101114},{"genreLevel" => 1,"genreName" => "食品","genreId" => 100227},{"genreLevel" => 1,"genreName" => "美容・コスメ・香水","genreId" => 100939},{"genreLevel" => 1,"genreName" => "本・雑誌・コミック","genreId" => 200162},{"genreLevel" => 1,"genreName" => "旅行・出張・チケット","genreId" => 101381},{"genreLevel" => 1,"genreName" => "不動産・住まい","genreId" => 200163},{"genreLevel" => 1,"genreName" => "学び・サービス・保険","genreId" => 101438},{"genreLevel" => 1,"genreName" => "百貨店・総合通販・ギフト","genreId" => 100000},{"genreLevel" => 1,"genreName" => "デジタルコンテンツ","genreId" => 402853},{"genreLevel" => 1,"genreName" => "車用品・バイク用品","genreId" => 503190},{"genreLevel" => 1,"genreName" => "インナー・下着・ナイトウエア","genreId" => 100433},{"genreLevel" => 1,"genreName" => "日本酒・焼酎","genreId" => 510901},{"genreLevel" => 1,"genreName" => "ビール・洋酒","genreId" => 510915},{"genreLevel" => 1,"genreName" => "スイーツ・お菓子","genreId" => 551167},{"genreLevel" => 1,"genreName" => "医薬品・コンタクト・介護","genreId" => 551169},{"genreLevel" => 1,"genreName" => "メンズファッション","genreId" => 551177},{"genreLevel" => 1,"genreName" => "靴","genreId" => 558885},{"genreLevel" => 1,"genreName" => "腕時計","genreId" => 558929},{"genreLevel" => 1,"genreName" => "キッチン用品・食器・調理器具","genreId" => 558944},{"genreLevel" => 1,"genreName" => "家電","genreId" => 562637}],"current" => [],"parent" => []}
        @genre = Rakumarket::Genre.parse(@response)
      end

      it 'should parse children' do
        @genre.children.should be_a(Array)
      end

      it 'should parse child genres' do
        @genre.children.first.should be_a(Rakumarket::Genre)
      end
    end

    context "child" do
      before do
        @response = {"child" => [{"genreLevel" => 4,"genreName" => "ドラム式","genreId" => 550648},{"genreLevel" => 4,"genreName" => "全自動（乾燥機能あり）","genreId" => 211835},{"genreLevel" => 4,"genreName" => "全自動（乾燥機能なし）","genreId" => 211851},{"genreLevel" => 4,"genreName" => "2槽式","genreId" => 211859},{"genreLevel" => 4,"genreName" => "洗濯機関連用品","genreId" => 211874},{"genreLevel" => 4,"genreName" => "その他","genreId" => 100180}],"current" => [{"genreLevel" => 3,"genreName" => "洗濯機","genreId" => 204491}],"parent" => [{"genreLevel" => 2,"genreName" => "生活 家電","genreId" => 204200}]}
        @genre = Rakumarket::Genre.parse(@response)
      end

      it "should parse id" do
        @genre.id.should eq(204491)
      end

      it "should parse name" do
        @genre.name.should eq("洗濯機")
      end

      it "should parse parent" do
        @genre.parent.should be_a(Rakumarket::Genre)
      end

      it 'should parse children' do
        @genre.children.should be_a(Array)
      end

      it 'should parse child genres' do
        @genre.children.first.should be_a(Rakumarket::Genre)
      end
    end
  end
end
