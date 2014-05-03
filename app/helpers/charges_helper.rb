module ChargesHelper
  
  def present_charge
    amount = @charge.amount
    { :amount => amount, :formattedAmount => "$#{Money.new(@charge.amount,"USD")}" }
  end
  
end
