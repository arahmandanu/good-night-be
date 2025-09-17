require 'rails_helper'

RSpec.describe Redis::User::FollowCache do
  let(:user) { User.create!(name: 'Test User') }

  describe '.key' do
    it 'returns the correct Redis key' do
      expect(described_class.key(user.id)).to eq("user:#{user.id}:total_followed")
    end
  end

  describe '.get_followed_count' do
    it 'returns count from Redis if present' do
      allow(REDIS).to receive(:get).with("user:#{user.id}:total_followed").and_return('5')
      expect(described_class.get_followed_count(user)).to eq(5)
    end

    it 'populates count from DB and sets Redis if missing' do
      allow(REDIS).to receive(:get).with("user:#{user.id}:total_followed").and_return(nil)
      expect(UserFollow).to receive(:where).with(user_id: user.id).and_return(double(count: 3))
      expect(REDIS).to receive(:set).with("user:#{user.id}:total_followed", 3)
      expect(described_class.get_followed_count(user)).to eq(3)
    end
  end

  describe '.increment_followed' do
    it 'increments followed count in Redis' do
      expect(REDIS).to receive(:incr).with("user:#{user.id}:total_followed")
      described_class.increment_followed(user.id)
    end
  end

  describe '.decrement_followed' do
    it 'decrements followed count in Redis' do
      expect(REDIS).to receive(:decr).with("user:#{user.id}:total_followed")
      described_class.decrement_followed(user.id)
    end
  end
end
