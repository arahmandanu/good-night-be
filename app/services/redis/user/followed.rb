class Redis::User::Followed
  KEY_PREFIX = "user:%{user_id}:followed_ids"

  def initialize(user_id)
    @user_id = user_id
  end

  attr_reader :user_id

  def key
    KEY_PREFIX % { user_id: user_id }
  end

  # Add followed_id and ensure cache exists
  def add(followed_id)
    ensure_cache!
    REDIS.lpush(key, followed_id)
  end

  # Remove followed_id from cache
  def remove(followed_id)
    ensure_cache!
    REDIS.lrem(key, 0, followed_id)
  end

  # Get followed_ids (auto recache if empty/missing)
  def get
    ids = REDIS.lrange(key, 0, -1)
    if ids.blank?
      recache
      ids = REDIS.lrange(key, 0, -1)
    end
    ids
  end

  # Force rebuild from DB
  def recache
    followed_ids = UserFollow.where(user_id: user_id).pluck(:followed_id)
    REDIS.multi do |r|
      r.del(key)
      followed_ids.each { |fid| r.rpush(key, fid) }
    end
    followed_ids
  end

  private

  def ensure_cache!
    exists = REDIS.exists?(key)
    recache unless exists
  end
end
