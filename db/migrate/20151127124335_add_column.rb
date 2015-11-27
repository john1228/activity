class AddColumn < ActiveRecord::Migration
  def change
    add_column :runnings, :likes_count, :integer, default: 0
    add_column :runnings, :views_count, :integer, default: 0
  end
end
