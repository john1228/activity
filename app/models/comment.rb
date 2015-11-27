class Comment < ActiveRecord::Base
  belongs_to :user
  enum source: [:running]
end
