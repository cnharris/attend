class AddChargeIndex < ActiveRecord::Migration
  def change
    add_index :charges, :charge_id
  end
end
