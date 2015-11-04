class Apply < ActiveRecord::Base
  validates_presence_of :name, message: '请填写您的真实姓名'
  validates_presence_of :mobile, message: '请填写您的手机号码'
  validates_presence_of :email, message: '请填写您的邮箱', if: Proc.new { |apply| apply.ace? }
  validates_uniqueness_of :mobile, message: '该手机号码已经报名'
  validates_uniqueness_of :email, message: '该邮箱已经使用', if: Proc.new { |apply| apply.ace? }
  enum activity_id: [:ace]
end
