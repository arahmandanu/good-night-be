class Redis::Sleeps::UserClockin
  REDIS_KEY_PREFIX = "user:clockin".freeze

  def initialize(user_id)
    @user_id = user_id
  end

  # Increment clock-in count
  def increment
    REDIS.hincrby(redis_key, "total", 1)
  end

  # Set the count manually
  def set(count)
    REDIS.hset(redis_key, "total", count)
  end

  # Get total clock-ins
  def total
    REDIS.hget(redis_key, "total").to_i
  end

  private

  attr_reader :user_id

  def redis_key
    "#{REDIS_KEY_PREFIX}:#{user_id}"
  end
end
