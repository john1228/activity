class Apply < ActiveRecord::Base
  validates_presence_of :name, message: '请填写您的真实姓名'
  validates_presence_of :mobile, message: '请填写您的手机号码'
  validates_presence_of :email, scope: :activity_id, message: '请填写您的邮箱'
  validates_uniqueness_of :mobile, scope: :activity_id, message: '该手机号码已经报名'
  validates_uniqueness_of :email, scope: :activity_id, message: '该邮箱已经使用'
  scope :nj, -> { where(activity_id: -1) }
  scope :ace, -> { where(activity_id: 0) }
  belongs_to :activity

  def activity_name
    case activity_id
      when -1
        '南京会议'
      when 0
        'ACE'
      else
        activity.title
    end
  end
end
