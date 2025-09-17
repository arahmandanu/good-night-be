class Redis::User::Get
  def initialize(user_id)
    @user_id = user_id
  end

  def call
    data = REDIS.get(redis_key)
    if data.blank?
      data = model.find_by(id: user_id)
      return nil if data.nil?

      REDIS.set(redis_key, data.to_json, ex: expire, nx: true)
      return data
    end

    cache_data = ActiveSupport::JSON.decode(data)
    model.instantiate(cache_data)
  rescue => _
    nil
  end

  private

  attr_reader :user_id

  def expire
    1.days
  end

  def model
    User
  end

  def redis_key
    "user:#{user_id}"
  end
end
