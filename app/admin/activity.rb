ActiveAdmin.register Activity do
  filter :title
  permit_params :title, :html_subtitle, :cover, :fee, :address, :limit, :start, :end, :html_body
  index do
    column :title
    column :cover do |activity|
      image_tag(activity.cover.url, width: (610/5), height: (264/5))
    end
    column :fee
    column :address
    column :limit do |activity|
      "#{activity.apply_count.to_i}/#{activity.limit.to_i}"
    end
    column :start do |activity|
      activity.start.strftime('%Y-%m-%d')
    end
    column :end do |activity|
      activity.end.strftime('%Y-%m-%d')
    end
    actions do |activity|
      link_to('日程安排', admin_activity_schedules_path(activity))
    end
  end

  show do
    attributes_table do
      row :title
      row :html_subtitle
      row :cover do
        image_tag(activity.cover.url, width: 610, height: 264)
      end
      row :fee
      row :address
      row :limit
      row :start do
        activity.start.strftime('%Y-%m-%d')
      end
      row :end do
        activity.end.strftime('%Y-%m-%d')
      end
      row :html_body do
        raw activity.html_body
      end
    end
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
    f.submit '提交'
  end
end
