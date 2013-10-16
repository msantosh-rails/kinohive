class AddHcFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_hivecoins, :integer, :default => 15
  end
end
