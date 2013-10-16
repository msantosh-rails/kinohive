class AddAdminHivecinsFieldToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :admin_hivecoins, :integer
  end
end
