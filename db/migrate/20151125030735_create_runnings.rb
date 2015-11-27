class CreateRunnings < ActiveRecord::Migration
  def change
    create_table :runnings do |t|
      t.integer :phase
      t.string :name
      t.integer :follows_count, default: 0
      t.string :cover
      t.string :url
      t.timestamps null: false
    end
  end
end
