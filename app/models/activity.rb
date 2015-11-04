class Activity < ActiveRecord::Base
  has_many :intros, class: ActivityIntro
  has_many :shows, class: ActivityShow
end
