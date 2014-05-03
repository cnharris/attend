class CreateUsers < ActiveRecord::Migration
  
  def change
    create_table :users do |t|
      t.string :name
      t.string :company
      t.string :email 
      t.string :phone
      t.integer :subscription_id
      t.string :stripe_customer_id
      t.timestamps
    end
  end
  
end
