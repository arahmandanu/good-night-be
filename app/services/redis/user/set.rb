class Redis::User::Set
  def initialize(record_user)
    @record_user = record_user
  end

  def call
    REDIS.set(redis_key, @record_user.to_json, ex: expire, nx: true)
    true
  rescue => _
    false
  end

  private

  attr_reader :record_user

  def expire
    1.days
  end

  def model
    User
  end

  def redis_key
    "user:#{record_user.id}"
  end
end
