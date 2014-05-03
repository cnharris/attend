class UsersController < ApplicationController
  include UsersHelper
  
  def create
    @user = User.find_or_initialize_by(user_params)
    subscription = Subscription.find(params[:subscription])
    raise "Nil subscription returned." if subscription.blank?
    amount = subscription.amount
    raise "Nil subscription amount returned." if subscription.blank?
    
    get_customer_id
    response = process_charge({ :token => params[:token], :amount => amount })
    
    render :json => present_response(response)
    
  end
  
  private
  
    def user_params
      params.with_indifferent_access.permit(:name, :company, :email, :phone, :created_at)
    end
  
end
