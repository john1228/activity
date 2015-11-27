class AddColumn < ActiveRecord::Migration
  def change
    add_column :runnings, :likes_count, default: 0
    add_column :runnings, :views_count, default: 0
  end
end
