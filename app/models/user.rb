class User < ActiveRecord::Base
  has_one :subscription
  has_many :charges
  
end
