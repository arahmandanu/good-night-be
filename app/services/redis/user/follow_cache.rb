class Redis::User::FollowCache
  # Generate a unique Redis key per user
  def self.key(user_id)
    "user:#{user_id}:total_followed"
  end

  # Get count from Redis, populate if missing
  def self.get_followed_count(user)
    user_id = user.is_a?(User) ? user.id : user
    value = REDIS.get(key(user_id))

    return value.to_i if value.present?

    # Lazy populate from DB
    count = UserFollow.where(user_id: user_id).count
    REDIS.set(key(user_id), count)
    count
  end

  def self.increment_followed(user_id)
    REDIS.incr(key(user_id))
  end

  def self.decrement_followed(user_id)
    REDIS.decr(key(user_id))
  end
end
