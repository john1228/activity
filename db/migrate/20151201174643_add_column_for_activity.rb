class AddColumnForActivity < ActiveRecord::Migration
  def change
    add_column :activities, :html_body, :text
    add_column :activities, :html_subtitle, :text
  end
end
