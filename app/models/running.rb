class Running < ActiveRecord::Base
  has_many :follows, dependent: :destroy
end
