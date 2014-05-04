require "spec_helper"

describe "User" do
  
  before(:each) do
    @user = User.create!(
      :name => "Chris",
      :company => "Groupon",
      :email => "cnharris@gmail.com",
      :phone => "6506781417",
      :subscription_id => 1,
      :stripe_customer_id => "123abc" 
    )
  end
  
  describe "#create" do
    
    it "creates a user" do
      @user.name.should == "Chris"
      @user.company.should == "Groupon"
      @user.email.should == "cnharris@gmail.com"
      @user.phone.should == "6506781417"
      @user.subscription_id.should == 1
      @user.stripe_customer_id.should == "123abc"
    end
    
    it "should error on a blank name" do
      @user = User.create(
        :name => "",
        :company => "Groupon",
        :email => "cnharris@gmail.com",
        :phone => "6506781417",
        :subscription_id => 1,
        :stripe_customer_id => "123abc" 
      )
      @user.errors[:name][0].should == "can't be blank"
    end
    
    it "should error on a blank company" do
      @user = User.create(
        :name => "Chris",
        :company => "",
        :email => "cnharris@gmail.com",
        :phone => "6506781417",
        :subscription_id => 1,
        :stripe_customer_id => "123abc" 
      )
      @user.errors[:company][0].should == "can't be blank"
    end
    
    it "should error on an invalid email" do
      @user = User.create(
        :name => "Chris",
        :company => "Groupon",
        :email => "cnharris",
        :phone => "6506781417",
        :subscription_id => 1,
        :stripe_customer_id => "123abc" 
      )
      @user.errors[:email][0].should == "should be a valid email address"
    end
    
    it "should error on an invalid phone number" do
      @user = User.create(
        :name => "Chris",
        :company => "Groupon",
        :email => "cnharris@gmail.com",
        :phone => "650678141",
        :subscription_id => 1,
        :stripe_customer_id => "123abc" 
      )
      @user.errors[:phone][0].should == "should be a valid phone number"
    end
    
  end
  
end