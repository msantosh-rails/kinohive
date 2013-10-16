class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :page
      t.string :ip_address
      t.string :location

      t.timestamps
    end
  end
end
