class ChargesController < ApplicationController
  include ChargesHelper
  
  def show
    @charge = Charge.find(params[:id])
    raise "Charge could not be found" if @charge.blank?
    if @charge.present?
      render :json => present_charge
    end
  end
  
end
