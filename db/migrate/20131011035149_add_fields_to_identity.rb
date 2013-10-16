class AddFieldsToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :confirmation_token, :string
    add_column :identities, :confirmed_at, :datetime
    add_column :identities,  :verified, :boolean
  end
end
