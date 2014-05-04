class Subscription < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true
  validates :amount, presence: true, :numericality => { only_integer: true, :message => "is an invalid integer" }
  
end
