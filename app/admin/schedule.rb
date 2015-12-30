ActiveAdmin.register Schedule do
  belongs_to :activity
  navigation_menu :activity

  config.filters = false

  permit_params :title, :activity_id, :date, :start, :end, :tutor, :address

  index do
    selectable_column
    column :title
    column :date do |schedule|
      schedule.date.strftime('%Y-%m-%d')
    end
    column :start
    column :end
    column :tutor
    column :address
    actions
  end

  show do
    attributes_table do
      row :title
      row :date do
        schedule.date.strftime('%Y-%m-%d')
      end
      row :start
      row :end
      row :tutor
      row :address
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :activity, as: :hidden
      f.input :date, as: :datepicker
      f.input :start, input_html: {class: 'time-picker'}
      f.input :end, input_html: {class: 'time-picker'}
      f.input :tutor
      f.input :address
    end
    f.submit('确认')
  end
end
