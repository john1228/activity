class CreateActivityShows < ActiveRecord::Migration
  def change
    create_table :activity_shows do |t|
      t.integer :user_id
      t.string :content
      t.string :image, array: true
      t.timestamps null: false
    end
  end
end
