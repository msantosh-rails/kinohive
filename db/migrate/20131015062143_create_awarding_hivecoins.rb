class CreateAwardingHivecoins < ActiveRecord::Migration
  def change
    create_table :awarding_hivecoins do |t|
      t.integer :hivecoin
      t.integer :video_id
      t.integer :user_id

      t.timestamps
    end
  end
end
