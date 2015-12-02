ActiveAdmin.register Apply do
  filter :mobile
  filter :name
  filter :email
  filter :created_at
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
