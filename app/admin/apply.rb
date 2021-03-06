ActiveAdmin.register Apply do
  filter :mobile
  filter :name
  filter :email
  filter :created_at
  filter :activity_id, as: :select, collection: proc { Activity.pluck(:title, :id) << ['ACE', 0] << ['南京会议', -1] }

  actions :index

  index do
    column :activity_name
    column :mobile
    column :name
    column :email
    column :created_at do |apply|
      apply.created_at.localtime.strftime('%Y-%m-%d %H:%M')
    end
  end
end
