class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :title
      t.string :cover
      t.datetime :start
      t.datetime :end
      t.datetime :enroll
      t.string :address
      t.string :gather
      t.integer :limit
      t.integer :fee
      t.text :stay
      t.text :insurance
      t.text :tip
      t.text :bak
      t.integer :apply_count
      t.integer :view_count
      t.timestamps null: false
    end
  end
end
