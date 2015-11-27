class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mobile
      t.string :password
      t.string :name
      t.string :gender
      t.string :salt
      t.string :source
      t.timestamps null: false
    end
  end
end
