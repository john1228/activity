class AddColumnForActivity < ActiveRecord::Migration
  def change
    add_column :activities, :html_body, :text
    add_column :activities, :html_subtitle, :text
    change_column :activities, :start, :date
    change_column :activities, :end, :date
    change_column_default :activities, :apply_count, 0
  end
end
