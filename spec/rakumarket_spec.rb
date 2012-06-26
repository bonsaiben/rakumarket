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
        @items.should_not be_empty
      end

      it "returns items with attributes" do
        @items.first.name.should eq('【現定数在庫有り】ルンバ 530 新品 楽天最安挑戦価格 安心の3年保証 オマケ付き ルンバ530 ホワイト iRobot Roomba 正規品 【c_1011】【2sp_120528_b】')
      end

      it "returns items with rubyish attributes" do
        @items.first.review_count.should_not be_nil
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
        items.should_not be_empty
      end

      it "accepts nested parameters" do
        items = Rakumarket.item_search("roomba", :price => {:maximum => 30000} ).items
        items.should_not be_empty
      end

      it "accepts SQL-style order specification" do
        items = Rakumarket.item_search("roomba", :order => 'updated_at asc' ).items
        items.should_not be_empty
      end

      it "accepts case insensitive SQL-style order specification" do
        items = Rakumarket.item_search("roomba", :order => 'updated_at ASC' ).items
        items.should_not be_empty
      end

      it "accepts plain country names for international shipping" do
        items = Rakumarket.item_search("roomba", :shipping => {:must_ship_international => true, :country => 'usa'} ).items
        items.should_not be_empty
      end

      it "accepts plain prefecture names for next day shipping" do
        items = Rakumarket.item_search("roomba", :shipping => {:must_ship_next_day => true, :next_day_area => 'kanagawa'} ).items
        items.should_not be_empty
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

    context "given a fruitless search" do
      it "raises an error " do
        expect{ 
          items = Rakumarket.item_search("askdjfalsjdf")
        }.to raise_error(Rakumarket::RakumarketError)
      end
    end
  end


  describe "#genre_search" do
    before do
      VCR.insert_cassette 'genre_search', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    context "given a simple search" do
      before do
        @response = Rakumarket.genre_search
      end
      it "returns a list of genres" do
        @response.children.should be_a(Array)
      end
      it "returns a single parent" do
        @response.parent.should_not be_a(Array)
      end
      it "returns genres with attributes" do
        @response.children.first.name.should eq('CD・DVD・楽器')
      end
    end

    context "given a search with a genre id" do
      before do
        @response = Rakumarket.genre_search(101240)
      end
      it "returns a list of genres" do
        @response.children.should be_a(Array)
      end
      it "returns a single parent" do
        @response.parent.should_not be_a(Array)
      end
      it "returns genres with attributes" do
        @response.children.first.name.should eq('DVD')
      end
      it "returns the topmost parent" do
        response = Rakumarket.genre_search(204491)
        response.parent.name.should eq('家電')
      end
    end

    context "given a search with parameters" do
      it "accepts rubyish parameter names" do
        response = Rakumarket.genre_search(0, :return_immediate_parent => false)
        response.children.should_not be_empty
      end
      it "returns the immediate parent" do
        response = Rakumarket.genre_search(204491, :return_immediate_parent => true)
        response.parent.name.should eq('生活家電')
      end
    end

    context "given a fruitless search" do
      it "raises an error " do
        expect{ 
          items = Rakumarket.genre_search("askdjfalsjdf")
        }.to raise_error(Rakumarket::RakumarketError)
      end
    end
  end

  describe "#item_lookup" do
    before do
      VCR.insert_cassette 'item_lookup', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    context "given a simple search" do
      before do
        @response = Rakumarket.item_lookup "act-corp:10000580"
      end

      it "returns an item" do
        @response.should be_a(Rakumarket::Item)
      end

      it "returns an item with item attributes" do
        @response.code.should eq("act-corp:10000580")
      end
    end
  end

end
