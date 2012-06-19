# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Rakumarket do
  
  it "slices a hash" do
    {:keep => "this", :drop => "that"}.slice(:keep).should eq({:keep => "this"})
  end

  describe "#item_search" do
    before do
      VCR.insert_cassette 'item_search', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    context "given a simple search" do
      before do
        @items = Rakumarket.item_search("roomba").items
      end

      it "returns a list of items" do
        @items.should be_present
      end

      it "returns items with attributes" do
        @items.first.name.should eq('【現定数在庫有り】ルンバ 530 新品 楽天最安挑戦価格 安心の3年保証 オマケ付き ルンバ530 ホワイト iRobot Roomba 正規品 【c_1011】【2sp_120528_b】')
      end

      it "returns items with rubyish attributes" do
        @items.first.review_count.should be_present
      end

      it "returns items with nested attributes" do
        @items.first.shipping.international?.should_not be_nil
      end

      it "returns time objects for attributes representing time" do
        items = Rakumarket.item_search("roomba").items
        items[20].start_time.should be_a(Time)
      end

      it "returns nil for blank attributes representing time" do
        items = Rakumarket.item_search("roomba").items
        items.first.start_time.should be_nil
      end
    end

    context "given a search with parameters" do
      it "accepts rubyish parameter names" do
        items = Rakumarket.item_search("roomba", :must_have_image => true).items
        items.should be_present
      end

      it "accepts nested parameters" do
        items = Rakumarket.item_search("roomba", :price => {:maximum => 30000} ).items
        items.should be_present
      end

      it "accepts SQL-style order specification" do
        items = Rakumarket.item_search("roomba", :order => 'updated_at asc' ).items
        items.should be_present
      end

      it "accepts case insensitive SQL-style order specification" do
        items = Rakumarket.item_search("roomba", :order => 'updated_at ASC' ).items
        items.should be_present
      end

      it "accepts plain country names for international shipping" do
        items = Rakumarket.item_search("roomba", :shipping => {:must_ship_international => true, :country => 'usa'} ).items
        items.should be_present
      end

      it "accepts plain prefecture names for next day shipping" do
        items = Rakumarket.item_search("roomba", :shipping => {:must_ship_next_day => true, :next_day_area => 'kanagawa'} ).items
        items.should be_present
      end

      it "returns plain country names for international shipping" do
        items = Rakumarket.item_search("roomba", :shipping => {:must_ship_international => true, :country => 'usa'} ).items
        items.first.shipping.countries.should eq(["worldwide"])
      end

      it "returns plain prefecture names for next day shipping" do
        items = Rakumarket.item_search("roomba", :shipping => {:must_ship_next_day => true, :next_day_area => 'kanagawa'} ).items
        items.first.shipping.next_day_areas.should include("kanagawa")
      end
    end

    context "given a search with genre information" do
      before do
        @genre_info = Rakumarket.item_search("roomba", :include_genre_info => true).genre_info
      end

      it "returns genre information" do
        @genre_info.should be_present
      end

      it "returns an array of children" do
        @genre_info.children.should be_a(Array)
      end

      it "returns a single parent" do
        @genre_info.parent.should_not be_a(Array)
      end

      it "returns the current" do
        @genre_info.current.should_not be_a(Array)
      end
    end

    context "given a fruitless search" do
      it "raises an error " do
        expect{ 
          items = Rakumarket.item_search("askdjfalsjdf")
        }.to raise_error(Rakumarket::RakumarketError)
      end
    end

  end

end
