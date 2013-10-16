class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.boolean :content
      t.boolean :editing
      t.boolean :shots
      t.boolean :concept
      t.integer :video_id
      t.integer :user_id

      t.timestamps
    end
  end
end
