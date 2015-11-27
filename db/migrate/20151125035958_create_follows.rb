class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :source
      t.integer :link_id
      t.references :user
      t.timestamps null: false
    end
  end
end
