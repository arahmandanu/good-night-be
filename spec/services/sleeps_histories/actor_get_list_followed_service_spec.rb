require 'rails_helper'

RSpec.describe SleepsHistories::ActorGetListFollowedService do
  let(:user) { User.create!(name: 'Test User') }
  let(:followed) { User.create!(name: 'Followed User') }
  let!(:follow) { UserFollow.create!(user_id: user.id, followed_id: followed.id) }
  let!(:sleep_record) { Sleep.create!(user_id: followed.id, start_time: 1.day.ago, end_time: 1.day.ago + 8.hours, duration_seconds: 8*3600) }

  let(:valid_params) do
    {
      user_id: user.id,
      start_date: 2.days.ago.to_date,
      end_date: Date.today,
      page: 1,
      per_page: 10
    }
  end

  let(:invalid_params) { valid_params.merge(user_id: 'invalid') }

  describe '#call' do
    context 'with valid params' do
      it 'returns followed users sleep histories and success' do
        result = described_class.new(valid_params).call
        expect(result).to be_success
        expect(result.value).to be_a(Hash)
        expect(result.value).to have_key(:data)
        expect(result.value[:data]).to be_a(Array)
        expect(result.value[:data].first).to include(:id, :start_time, :end_time, :duration_seconds, :user)
      end
    end

    context 'with invalid params' do
      it 'returns failure with contract errors' do
        result = described_class.new(invalid_params).call
        expect(result).to be_failure
        expect(result.error).to respond_to(:errors)
      end
    end
  end
end
