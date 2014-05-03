class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :charge_id
      t.string :amount
      t.string :card_type
      t.string :number
      t.string :month
      t.string :year
      t.belongs_to :user
      t.timestamps
    end
  end
end