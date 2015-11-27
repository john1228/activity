class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :replier, class: User, foreign_key: :reply_id
  enum source: [:running]

  def created
    seconds = Time.now - created_at
    if seconds <60
      '刚刚'
    elsif seconds< 60*60
      "#{(seconds/60).to_i}分钟"
    elsif seconds< 60*60*24
      "#{(seconds/(60*60)).to_i}小时前"
    elsif seconds < 60*60*24*7
      "#{(seconds/(60*60*24)).to_i}天前"
    elsif seconds< 60*60*24*30
      "#{(seconds/(60*60*24*7)).to_i}周前"
    elsif seconds < 60*60*24*365
      "#{(seconds/(60*60*24*30)).to_i}月前"
    else
      "#{(seconds/(60*60*24*365)).to_i}年前"
    end
  end
end
