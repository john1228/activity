class CreateActivityIntros < ActiveRecord::Migration
  def change
    create_table :activity_intros do |t|
      t.references :activity
      t.string :title
      t.string :instruction
      t.string :image, array: true, default: []
    end
  end
end
