class AddFieldResetTokenToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :reset_token, :string
  end
end
