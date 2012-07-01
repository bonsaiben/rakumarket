# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Rakumarket do
  
  it "slices a hash" do
    {:keep => "this", :drop => "that"}.slice(:keep).should eq({:keep => "this"})
  end

  describe "#item_search" do
    context "given a valid search" do
      before do
        stub_request(:any, /.*operation=ItemSearch.*/).to_return(:body => fixture_file('item_search.json'))
        @items = Rakumarket.item_search("roomba")
      end

      it "returns an item list" do
        @items.should be_a(Rakumarket::ItemList)
      end

      it "returns items" do
        @items.items.first.should be_a(Rakumarket::Item)
      end
    end

    context "given an invalid search" do
      before do
        stub_request(:any, /.*operation=ItemSearch.*/).to_return(:body => fixture_file('item_search_not_found.json'))
      end

      it "raises an error " do
        expect{ 
          items = Rakumarket.item_search("askdjfalsjdf")
        }.to raise_error(Rakumarket::RakumarketError)
      end
    end
  end

  describe "#genre_search" do
    before do
      stub_request(:any, /.*operation=GenreSearch.*/).to_return(:body => fixture_file('genre_search.json'))
      @response = Rakumarket.genre_search
    end

    it "returns a list of genres" do
      @response.children.should be_a(Array)
    end

    it "returns a single parent" do
      @response.parent.should_not be_a(Array)
    end
  end

  describe "#item_lookup" do
    before do
      stub_request(:any, /.*operation=ItemCodeSearch.*/).to_return(:body => fixture_file('item_code_search.json'))
      @response = Rakumarket.item_lookup "act-corp:10000580"
    end

    it "returns an item" do
      @response.should be_a(Rakumarket::Item)
    end

    it "returns an item with item attributes" do
      @response.code.should eq("act-corp:10000580")
    end
  end

  describe "#item_ranking" do
    before do
      stub_request(:any, /.*operation=ItemRanking.*/).to_return(:body => fixture_file('item_ranking.json'))
      @response = Rakumarket.item_ranking :sex => :male
    end

    it "returns an item list" do
      @response.should be_a(Rakumarket::ItemList)
    end

    it "return items" do
      @response.items.first.should be_a(Rakumarket::Item)
    end
  end

end
