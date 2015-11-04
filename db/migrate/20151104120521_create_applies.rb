class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.integer :activity_id
      t.integer :user_id
      t.string :name
      t.string :mobile
      t.string :email
      t.timestamps null: false
    end
  end
end
