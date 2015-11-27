class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :source
      t.integer :source_id
      t.references :user
      t.string :content
      t.string :image, array: true
      t.integer :likes_count, default: 0
      t.timestamps null: false
    end
  end
end
