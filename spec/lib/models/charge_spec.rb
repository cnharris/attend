require "spec_helper"

describe "Charge" do
  
  before(:each) do
    @charge = Charge.create!(
      :charge_id => "123abc",
      :amount => 10000,
      :card_type => "visa",
      :number => 4444,
      :month => 01,
      :year => 2015
    )
  end
  
  describe "#create" do
    
    it "creates a user" do
      @charge.charge_id.should == "123abc"
      @charge.amount.should == 10000
      @charge.card_type.should == "visa"
      @charge.number.should == 4444
      @charge.month.should == 01
      @charge.year == 2015
    end
    
    it "errors on a blank charge_id" do
      @charge_bad = Charge.create(
        :charge_id => "",
        :amount => 10000,
        :card_type => "visa",
        :number => 4444,
        :month => 01,
        :year => 2015
      )
      @charge_bad.errors[:charge_id][0].should == "can't be blank"
    end
    
    it "errors on an invalid amount" do
      @charge_bad = Charge.create(
        :charge_id => "123abc",
        :amount => "bad",
        :card_type => "visa",
        :number => 4444,
        :month => 01,
        :year => 2015
      )
      @charge_bad.errors[:amount][0].should == "should be a valid integer"
    end
    
    it "errors on an invalid card_type" do
      @charge_bad = Charge.create(
        :charge_id => "123abc",
        :amount => 10000,
        :card_type => "",
        :number => 4444,
        :month => 01,
        :year => 2015
      )
      @charge_bad.errors[:card_type][0].should == "can't be blank"
    end
    
    it "errors on an invalid number" do
      @charge_bad = Charge.create(
        :charge_id => "123abc",
        :amount => 10000,
        :card_type => "",
        :number => "bad",
        :month => 01,
        :year => 2015
      )
      @charge_bad.errors[:number][0].should == "should be a 4 digit value"
    end
    
    it "errors on an invalid month" do
      @charge_bad = Charge.create(
        :charge_id => "123abc",
        :amount => 10000,
        :card_type => "",
        :number => "bad",
        :month => 99,
        :year => 2015
      )
      @charge_bad.errors[:month][0].should == "is not included in the list"
    end
    
    it "errors on an invalid year" do
      @charge_bad = Charge.create(
        :charge_id => "123abc",
        :amount => 10000,
        :card_type => "",
        :number => "bad",
        :month => 4,
        :year => 2025
      )
      @charge_bad.errors[:year][0].should == "is not included in the list"
    end
    
  end
  
end