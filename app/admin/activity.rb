ActiveAdmin.register Activity do
  filter :title
  permit_params :title, :html_subtitle, :cover, :fee, :address, :limit, :start, :end, :html_body
  index do
    column :title
    column :cover
    column :fee
    column :address
    column :limit do |activity|
      "#{activity.apply_count.to_i}/#{activity.limit.to_i}"
    end
    column :start
    column :end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :html_subtitle, input_html: {rows: 3}
      f.input :cover, as: :file
      f.input :fee
      f.input :address
      f.input :limit
      f.input :start, as: :datepicker
      f.input :end, as: :datepicker
      f.cktext_area :html_body, :class => 'ckeditor'
    end
  end
end
