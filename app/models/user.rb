class User < ActiveRecord::Base
  has_one :subscription
  has_many :charges
  
  validates :name, presence: true
  validates :company, presence: true
  validates :email, format: { with: /\A\S+@\S+\z/, message: "should be a valid email address" }
  validates :phone, format: { with: /\A(\(\d{3}\)(|\s)|\d{3}|)-?\d{3}-?\d{4}\z/, message: "should be a valid phone number" }  
  
end
