require 'rails_helper'

RSpec.describe Redis::Sleeps::UserClockIn do
  let(:user_id) { SecureRandom.uuid }
  let(:service) { described_class.new(user_id) }

  describe '#increment' do
    it 'increments clock-in count in Redis' do
      expect(REDIS).to receive(:hincrby).with("user:clockin:#{user_id}", "total", 1)
      service.increment
    end
  end

  describe '#set' do
    it 'sets clock-in count in Redis' do
      expect(REDIS).to receive(:hset).with("user:clockin:#{user_id}", "total", 5)
      service.set(5)
    end
  end

  describe '#total' do
    it 'gets total clock-ins from Redis' do
      allow(REDIS).to receive(:hget).with("user:clockin:#{user_id}", "total").and_return('7')
      expect(service.total).to eq(7)
    end
  end

  describe '#redis_key' do
    it 'returns the correct Redis key' do
      expect(service.send(:redis_key)).to eq("user:clockin:#{user_id}")
    end
  end
end
