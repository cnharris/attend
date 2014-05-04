require "spec_helper"

describe "Subscription" do
  
  before(:each) do
    @subscription = Subscription.create!(
      :amount => 10000,
      :title => "Some title",
    )
  end
  
  describe "#create" do
    
    it "creates a subscription" do
      @subscription.amount.should == 10000
      @subscription.title.should == "Some title"
    end
    
    it "should raise an error on an invalid amount" do
      @subscription_bad = Subscription.create(
        :amount => "/?%$",
        :title => "Some title",
      )
      @subscription_bad.errors.messages[:amount][0].should == "is an invalid integer"
    end
    
    it "should raise an error on a blank title" do
      @subscription_bad = Subscription.create(
        :amount => "10000",
        :title => "",
      )
      @subscription_bad.errors.messages[:title][0].should == "can't be blank"
    end
    
    
  end
  
end