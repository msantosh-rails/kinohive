class AddFieldsToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :name, :string
    add_column :admins, :hivetype, :string
    add_column :admins, :age, :integer
    add_column :admins, :city, :string
    add_column :admins, :state, :string
    add_column :admins, :zipcode, :string
    add_column :admins, :role, :string
  end
end
