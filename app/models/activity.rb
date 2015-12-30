class Activity < ActiveRecord::Base
  has_many :intros, class: ActivityIntro, dependent: :destroy
  has_many :shows, class: ActivityShow, dependent: :destroy
  has_many :schedules, dependent: :destroy

  mount_uploader :cover, CoverUploader

  def created
    created_at.localtime.strftime('%Y-%m-%d %H:%M')
  end

  def cover_url
    cover.url
  end
end
