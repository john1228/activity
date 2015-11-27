class Follow < ActiveRecord::Base
  enum source: [:running]
  belongs_to :running, foreign_key: :link_id, counter_cache: :follows_count
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :link_id
end
