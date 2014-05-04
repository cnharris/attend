class Charge < ActiveRecord::Base
  belongs_to :user
  
  validates :charge_id, presence: true
  validates :amount, presence: true, :numericality => { only_integer: true, :message => "should be a valid integer" }
  validates :card_type, presence: true
  validates :number, presence: true, format: { with: /\A[0-9]{4}\z/, message: "should be a 4 digit value" }
  validates :month, presence: true, :inclusion => { :in => 1..12 }, length: { in: 1..2 }, :numericality => { only_integer: true, :message => "should be 2 integers long between 01 and 12" }
  validates :year, presence: true, :inclusion => { :in => 2015..2020 }, length: { is: 4 }, :numericality => { only_integer: true, :message => "should be 4 integers long between 2015 and 2020" }
  
  {:charge_id=>"ch_103yPc2W2ZSnS8hIk72chrRx", :amount=>39900, :card_type=>"Visa", :number=>"4242", :month=>4, :year=>2016}
  
end