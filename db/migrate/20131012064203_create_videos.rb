class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_title
      t.string :video_url
      t.string :video_pic
      t.integer :video_hivecoins
      t.integer :user_id

      t.timestamps
    end
  end
end
