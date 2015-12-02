class Activity < ActiveRecord::Base
  has_many :intros, class: ActivityIntro
  has_many :shows, class: ActivityShow

  mount_uploader :cover, CoverUploader

  def created
    created_at.localtime.strftime('%Y-%m-%d %H:%M')
  end
end
