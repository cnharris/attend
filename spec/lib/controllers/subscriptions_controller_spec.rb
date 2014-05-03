require 'spec_helper'

describe SubscriptionsController, :type => :controller do
  
  describe "Index action" do
    
    it "successfully presents all subscription types" do
      Subscription.should_receive(:all).and_return([ 
        { :id => 1, :title => "Title 1", :amount => 10000 },
        { :id => 2, :title => "Title 2", :amount => 20000 }
      ])
      
      get :index, :format => :json
      response.should be_success
      
      body = JSON.parse(response.body)
      body[0]["id"].should == 1
      body[0]["title"].should == "Title 1"
      body[0]["amount"].should == 10000
      body[1]["id"].should == 2
      body[1]["title"].should == "Title 2"
      body[1]["amount"].should == 20000
    end
    
    it "errors when a charge record cannot be found" do
      Subscription.should_receive(:all).and_return([])
      
      expect {
        get :index, :format => :json
      }.to raise_error
    end
      
  end
  
end