# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Rakumarket::Client do

  describe "parameters" do
    it "should transform developer_id" do
      params = {:developer_id => "abcd"}
      Rakumarket::Client.new(params).parse.should eq({'developerId' => "abcd"})
    end
  end

end


describe Rakumarket::ItemSearchClient do

  describe "parameters" do
    it "should have an operation by default" do
      params = {}
      Rakumarket::ItemSearchClient.new(params).parse['operation'].should eq("ItemSearch")
    end

    it "should have a version by default" do
      params = {}
      Rakumarket::ItemSearchClient.new(params).parse['version'].should eq("2010-09-15")
    end

    it "should have a developer_id by default" do
      params = {}
      Rakumarket::ItemSearchClient.new(params).parse['developerId'].should eq(ENV['DEVELOPER_ID'])
    end

    it "should transform a keyword" do
      params = {:keyword => "roomba"}
      Rakumarket::ItemSearchClient.new(params).parse['keyword'].should eq("roomba")
    end

    it "should transform a page" do
      params = {:page => "thepage"}
      Rakumarket::ItemSearchClient.new(params).parse['page'].should eq("thepage")
    end

    describe "price" do
      before do
        @params = {:price => {:minimum => 20, :maximum => 30}}
      end

      it "should transform a price minimum" do
        Rakumarket::ItemSearchClient.new(@params).parse['minPrice'].should eq(20)
      end

      it "should transform a price maximum" do
        Rakumarket::ItemSearchClient.new(@params).parse['maxPrice'].should eq(30)
      end
    end

    it "should transform a mobile" do
      params = {:mobile => true}
      Rakumarket::ItemSearchClient.new(params).parse['carrier'].should eq("1")
    end

    describe "shipping" do
      before do
        @params = {:shipping => {:must_ship_international => true, :country => 'france', :must_ship_next_day => true, :next_day_area => "kanagawa", :must_include_cost => true}}
      end

      it "should transform must_ship_international" do
        Rakumarket::ItemSearchClient.new(@params).parse['shipOverseasFlag'].should eq("1")
      end

      it "should transform country" do
        Rakumarket::ItemSearchClient.new(@params).parse['shipOverseasArea'].should eq("FR")
      end

      it "should transform must_ship_next_day" do
        Rakumarket::ItemSearchClient.new(@params).parse['asurakuFlag'].should eq("1")
      end

      it "should transform next_day_area" do
        Rakumarket::ItemSearchClient.new(@params).parse['asurakuArea'].should eq("14")
      end

      it "should transform must_include_cost" do
        Rakumarket::ItemSearchClient.new(@params).parse['postageFlag'].should eq("1")
      end
    end

    it "should transform affiliate_id" do
      params = {:affiliate_id => 123}
      Rakumarket::ItemSearchClient.new(params).parse['affiliateId'].should eq(123)
    end

    it "should transform call_back" do
      params = {:call_back => "thecallback"}
      Rakumarket::ItemSearchClient.new(params).parse['callBack'].should eq("thecallback")
    end

    it "should transform items_per_page" do
      params = {:items_per_page => "theitems_per_page"}
      Rakumarket::ItemSearchClient.new(params).parse['hits'].should eq("theitems_per_page")
    end

    it "should transform shop_code" do
      params = {:shop_code => "theshop_code"}
      Rakumarket::ItemSearchClient.new(params).parse['shopCode'].should eq("theshop_code")
    end

    it "should transform genre_id" do
      params = {:genre_id => "thegenre_id"}
      Rakumarket::ItemSearchClient.new(params).parse['genreId'].should eq("thegenre_id")
    end

    it "should transform order" do
      params = {:order => "price asc"}
      Rakumarket::ItemSearchClient.new(params).parse['sort'].should eq("+itemPrice")
    end

    it "should transform must_be_available" do
      params = {:must_be_available => true}
      Rakumarket::ItemSearchClient.new(params).parse['availability'].should eq("1")
    end

    it "should transform deep_search" do
      params = {:deep_search => true}
      Rakumarket::ItemSearchClient.new(params).parse['field'].should eq("0")
    end

    it "should transform must_have_image" do
      params = {:must_have_image => true}
      Rakumarket::ItemSearchClient.new(params).parse['imageFlag'].should eq("1")
    end
    
    it "should transform or_search" do
      params = {:or_search => true}
      Rakumarket::ItemSearchClient.new(params).parse['orFlag'].should eq("1")
    end

    it "should transform exclude_keyword" do
      params = {:exclude_keyword => "dog"}
      Rakumarket::ItemSearchClient.new(params).parse['NGKeyword'].should eq("dog")
    end

    it "should transform include_genre_info" do
      params = {:include_genre_info => true}
      Rakumarket::ItemSearchClient.new(params).parse['genreInformationFlag'].should eq("1")
    end

    it "should transform purchase_type" do
      params = {:purchase_type => "normal"}
      Rakumarket::ItemSearchClient.new(params).parse['purchaseType'].should eq(0)
    end

    it "should transform must_have_point_multiplication" do
      params = {:must_have_point_multiplication => true}
      Rakumarket::ItemSearchClient.new(params).parse['pointRateFlag'].should eq("1")
    end

    it "should transform point_multiplication_factor" do
      params = {:point_multiplication_factor => 2}
      Rakumarket::ItemSearchClient.new(params).parse['pointRate'].should eq(2)
    end

    it "should transform must_accept_credit_cards" do
      params = {:must_accept_credit_cards => true}
      Rakumarket::ItemSearchClient.new(params).parse['creditCardFlag'].should eq("1")
    end
  end

  describe Rakumarket::GenreSearchClient do

    describe "parameters" do
      it "should have an operation by default" do
        params = {}
        Rakumarket::GenreSearchClient.new(params).parse['operation'].should eq("GenreSearch")
      end

      it "should have a version by default" do
        params = {}
        Rakumarket::GenreSearchClient.new(params).parse['version'].should eq("2007-04-11")
      end

      it "should have a developer_id by default" do
        params = {}
        Rakumarket::GenreSearchClient.new(params).parse['developerId'].should eq(ENV['DEVELOPER_ID'])
      end
    end

    it "should transform genre_id" do
      params = {:genre_id => "abc"}
      Rakumarket::GenreSearchClient.new(params).parse['genreId'].should eq("abc")
    end

    it "should transform return_immediate_parent" do
      params = {:return_immediate_parent => true}
      Rakumarket::GenreSearchClient.new(params).parse['genrePath'].should eq("0")
    end
  end

  describe Rakumarket::ItemLookupClient do

    it "should transform code to itemCode" do
      params = {:code => "abc"}
      Rakumarket::ItemLookupClient.new(params).parse['itemCode'].should eq("abc")
    end

    context "with mobile" do
      it "should transform mobile to carrier" do
        params = {:mobile => true}
        Rakumarket::ItemLookupClient.new(params).parse.should have_key('carrier')
      end
      it "should transform true to 1" do
        params = {:mobile => true}
        Rakumarket::ItemLookupClient.new(params).parse['carrier'].should eq("1")
      end
      it "should transform false to 0" do
        params = {:mobile => false}
        Rakumarket::ItemLookupClient.new(params).parse['carrier'].should eq("0")
      end
    end

    describe "parameters" do
      before do
        params = {}
        @request = Rakumarket::ItemLookupClient.new(params)
      end

      it "should have an operation by default" do
        @request.parse['operation'].should eq("ItemCodeSearch")
      end

      it "should have a version by default" do
        @request.parse['version'].should eq("2010-08-05")
      end

      it "should have a developer_id by default" do
        @request.parse['developerId'].should eq(ENV['DEVELOPER_ID'])
      end
    end

  end
end
