class UserFollow < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: "User"

  validates :user_id, presence: true
  validates :followed_id, presence: true
  validates :followed_id, uniqueness: { scope: :user_id }

  after_create :increment_followed_cache
  after_destroy :decrement_followed_cache

  private

  def increment_followed_cache
    Redis::User::FollowCache.increment_followed(user.id)
  end

  def decrement_followed_cache
    Redis::User::FollowCache.decrement_followed(user.id)
  end
end
