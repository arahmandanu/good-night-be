require 'rails_helper'

RSpec.describe Redis::User::Set do
  let(:user) { User.create!(name: 'Test User') }
  let(:service) { described_class.new(user) }

  describe '#call' do
    it 'sets user data in Redis and returns true' do
      expect(REDIS).to receive(:set).with("user:#{user.id}", user.to_json, ex: 1.days, nx: true).and_return('OK')
      expect(service.call).to eq(true)
    end

    it 'returns false if Redis raises error' do
      allow(REDIS).to receive(:set).and_raise(StandardError.new('Redis error'))
      expect(service.call).to eq(false)
    end
  end

  describe '#redis_key' do
    it 'returns the correct Redis key' do
      expect(service.send(:redis_key)).to eq("user:#{user.id}")
    end
  end
end
