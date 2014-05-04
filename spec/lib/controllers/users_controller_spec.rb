require 'spec_helper'

describe UsersController, :type => :controller do
  
  describe "Create action" do
    
    before(:each) do
      @amount = 10000
      @name = "Chris Harris"
      @company = "Groupon"
      @email = "a@a.com"
      @phone = "650-678-1417"
      @customer_id = "customer_id_1"
      @token = "token"
    end
    
    it "successfully creates a user and processes a new charge" do
      # data
      @user = mock_model("User", :email => @email, :card => @token, :stripe_customer_id => nil)
      @subscription = mock_model("Subscription", :amount => @amount)
      @charge = mock_model("Charge")
      @stripe_charge = {
        :id          => 1,
        :amount      => @amount,
        :card => { 
          :type      => "some card", 
          :last4     => 1111, 
          :exp_month => 06, 
          :exp_year  => 15 
        }
      }
      
      # expectations
      User.should_receive(:find_or_initialize_by).with({
        "name"    => @name,
        "company" => @company,
        "email"   => @email,
        "phone"   => @phone,
      }).and_return(@user)
      Subscription.should_receive(:find).with(1).and_return(@subscription)
      Stripe::Customer.should_receive(:create).with(:email => @email, :card => @token).and_return(OpenStruct.new({ :id => @customer_id }))
      Stripe::Charge.should_receive(:create).with({
        :customer    => @customer_id,
        :amount      => @amount,
        :description => 'Credit Card charge for user: #{@user.name}',
        :currency    => 'usd'
      }).and_return(@stripe_charge)
      Charge.should_receive(:create!).and_return(@charge)
      @stripe_charge.should_receive(:is_a?).with(Stripe::Charge).and_return(true)
      @user.should_receive(:charges).and_return([])
      @user.should_receive(:stripe_customer_id=).with(@customer_id).and_return(true)
      @user.should_receive(:save!).and_return(true)
      
      post :create, {
        :name         => @name,
        :company      => @company,
        :email        => @email,
        :phone        => @phone,
        :subscription => 1,
        :token        => @token,
        :format       => :json
      }
      response.should be_success
      body = JSON.parse(response.body)
      body["status"].should == 200
      body["message"].should == "Charge successful"
    end
      
  end
  
end