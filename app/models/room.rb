class Room < ApplicationRecord
  has_many :tweets
  
  #tweetsを通してuserの所属してるroomsをとってくる
  has_many :users, through: :tweets

  has_many :joined_users, through: :tweets, source: :user

  def already_joining?(user)
    self.tweets.exists?(user_id: user.id)
  end
end
