class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :user_follows, foreign_key: :user_id, class_name: "UserFollow"
  has_many :followed_users, through: :user_follows, source: :followed
  has_many :sleeps, dependent: :destroy
end
