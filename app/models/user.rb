class User < ActiveRecord::Base
  enum source: [:running]
  before_save :encrypted_password
  class << self
    def login(login_params = {})
      user = User.find_by(mobile: login_params[:mobile])
      user if user.present?&&user.password.eql?(Digest::MD5.hexdigest("#{login_params[:password]}|#{user.salt}"))
    end
  end

  def token
    Digest::MD5.hexdigest("#{id}|#{salt}")
  end

  private
  def encrypted_password
    unless password_was.eql?(password)
      salt_arr = %w"a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9"
      self.salt = salt_arr.sample(18).join
      self.password = Digest::MD5.hexdigest("#{password}|#{self.salt}")
    end
  end
end
