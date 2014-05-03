require 'spec_helper'

describe ChargesController, :type => :controller do
  
  describe "Show action" do
    
    it "successfully presents a saved charge" do
      @charge = mock_model("Charge", :amount => 10000)
      Charge.should_receive(:find).with("1").and_return(@charge)
      
      get :show, :id => 1, :format => :json
      response.should be_success
      
      body = JSON.parse(response.body)
      body["amount"].should == 10000
      body["formattedAmount"].should == "$100.00"
    end
    
    it "errors when a charge record cannot be found" do
      @charge = mock_model("Charge", :amount => 10000)
      Charge.should_receive(:find).with("1").and_return(nil)
      
      expect {
        get :show, :id => 1, :format => :json
      }.to raise_error
    end
      
  end
  
end