# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Spitter do

  context "no conversion" do
    before do
      @params = {:code => "1234"}
      @spitter = Class.new(Spitter){ parameter :code }.new(@params)
    end

    it "should create the rules" do
      @spitter.class.rules.should eq({:code => ['code',nil]})
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'code' => '1234'})
    end
  end

  context "simple conversion" do
    before do
      @params = {:item_id => 1}
      @spitter = Class.new(Spitter){ parameter :item_id => 'itemId' }.new(@params)
    end

    it "should create the rules" do
      @spitter.class.rules.should eq({:item_id => ['itemId',nil]})
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'itemId' => 1})
    end
  end

  context "proc conversion" do
    before do
      @params = {:item_id => 1}
      @spitter = Class.new(Spitter){ parameter :item_id => lambda {|i| i.to_s.upcase }}.new(@params)
    end

    it "should create the rules" do
      @spitter.class.rules.should eq({:item_id => ['ITEM_ID',nil]})
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'ITEM_ID' => 1})
    end
  end

  context "class conversion" do
    before do
      @params = {:item_id => 1}
      klass = Class.new do
        def self.parse val
          val.upcase
        end
      end
      @spitter = Class.new(Spitter){ parameter :item_id => klass }.new(@params)
    end

    it "should create the rules" do
      @spitter.class.rules.should eq({:item_id => ['ITEM_ID',nil]})
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'ITEM_ID' => 1})
    end
  end

  context "value conversion with proc" do
    before do
      @params = {:is_cool => true}
      @spitter = Class.new(Spitter){ parameter :is_cool => 'isCool', :with => lambda { |a| a ? "1" : "0" } }.new(@params)
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'isCool' => '1'})
    end
  end

  context "value conversion with class" do
    before do
      @params = {:is_cool => true}
      klass = Class.new do
        def self.parse val
          val ? "1" : "0"
        end
      end
      @spitter = Class.new(Spitter){ parameter :is_cool => 'isCool', :with => klass }.new(@params)
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'isCool' => '1'})
    end
  end

  context "nested conversion" do
    before do
      @params = {:shop => {:name => "roomba", :code => "123"} }
      @spitter = Class.new(Spitter) do
        parameters :shop do
          parameter :name => 'shopName'
          parameter :code => 'shopCode'
        end
      end.new(@params)
    end

    it "should transform the params" do
      new_params = @spitter.parse
      new_params.should eq({'shopName' => 'roomba', 'shopCode' => '123'})
    end
  end

end
