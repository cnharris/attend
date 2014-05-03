require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  describe "Show action" do
    
    it "successfully presents a saved charge" do
      
      charge = mock_model("Charge")
      charge.stub(:amount,"10000")
      charge.should_receive(:find).and_return(charge)
      
      
      
    end
    
  end
  
end
