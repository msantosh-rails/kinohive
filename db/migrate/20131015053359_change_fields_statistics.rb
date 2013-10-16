class ChangeFieldsStatistics < ActiveRecord::Migration
  def up
	change_column :statistics, :content, :string
	change_column :statistics, :editing, :string
	change_column :statistics, :shots, :string
	change_column :statistics, :concept, :string
  end

  def down
  end
end
