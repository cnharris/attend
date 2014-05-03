module UsersHelper
  
  def get_user_params
    user_params = params[:user].with_indifferent_access
    raise "No user params supplied" if user_params.blank?
    user_params.select { |k,v| ["name","company","email","phone"].include?(k) }
  end
  
  def get_customer_id
    @customer_id ||= @user.stripe_customer_id
    return if @customer_id.present?
    customer = Stripe::Customer.create(:email => @user.email, :card => params[:token])
    @customer_id = customer.id
  end
  
  def process_charge(opts)
    Stripe::Charge.create(
      :customer    => @customer_id,
      :amount      => opts[:amount],
      :description => 'Credit Card charge for user: #{@user.name}',
      :currency    => 'usd'
    )
  end
  
  def present_response(response)
    if response.is_a?(Stripe::Charge)
      attrs = {
        :charge_id => response[:id],
        :amount => response[:amount],
        :card_type => response[:card][:type],
        :number => response[:card][:last4],
        :month => response[:card][:exp_month],
        :year => response[:card][:exp_year]
      }
      charge = Charge.new(attrs)
      charge.save!
      @user.charges << charge
      @user.stripe_customer_id = @customer_id
      @user.save!
      return { :status => 200, :message => "Charge successful", :charge => charge }
    else
      return { :status => 400, :message => "We're sorry, but we could not charge your card." }
    end
  end
  
end
