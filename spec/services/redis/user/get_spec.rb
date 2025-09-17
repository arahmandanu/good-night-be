require 'rails_helper'

RSpec.describe Redis::User::Get do
  let(:user) { User.create!(name: 'Test User') }
  let(:service) { described_class.new(user.id) }

  describe '#call' do
    it 'returns user from Redis cache if present' do
      cached_json = user.to_json
      allow(REDIS).to receive(:get).with("user:#{user.id}").and_return(cached_json)
      allow(User).to receive(:instantiate).and_call_original
      result = service.call
      expect(result).to be_a(User)
      expect(result.id).to eq(user.id)
    end

    it 'returns user from DB and sets cache if not present in Redis' do
      allow(REDIS).to receive(:get).with("user:#{user.id}").and_return(nil)
      expect(REDIS).to receive(:set).with("user:#{user.id}", user.to_json, ex: 1.days, nx: true)
      result = service.call
      expect(result).to be_a(User)
      expect(result.id).to eq(user.id)
    end

    it 'returns nil if user not found in DB or cache' do
      service = described_class.new('non-existent-id')
      allow(REDIS).to receive(:get).with("user:non-existent-id").and_return(nil)
      expect(service.call).to be_nil
    end

    it 'returns nil if an error occurs' do
      allow(REDIS).to receive(:get).and_raise(StandardError.new('Redis error'))
      expect(service.call).to be_nil
    end
  end

  describe '#redis_key' do
    it 'returns the correct Redis key' do
      expect(service.send(:redis_key)).to eq("user:#{user.id}")
    end
  end
end
