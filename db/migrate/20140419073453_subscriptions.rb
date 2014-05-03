class Subscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.integer :amount
      t.timestamps
    end
  end
end
