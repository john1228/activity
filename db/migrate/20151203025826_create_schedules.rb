class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :activity
      t.string :title
      t.date :date
      t.string :start
      t.string :end
      t.string :tutor
      t.string :address

      t.timestamps null: false
    end
  end
end
