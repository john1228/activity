class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :replier, class: User, foreign_key: :reply_id
  enum source: [:running]
end
