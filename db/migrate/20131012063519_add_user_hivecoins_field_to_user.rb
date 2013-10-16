class AddUserHivecoinsFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_hivecoins, :integer,:default => 15
  end
end
