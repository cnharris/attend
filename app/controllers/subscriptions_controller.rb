class SubscriptionsController < ApplicationController
  
  def index
    @subscriptions = Subscription.all
    raise "No subscriptions found" if @subscriptions.blank?
    render :json => @subscriptions
  end
  
end
