require 'rails_helper'

RSpec.describe SleepsHistories::ActorGetListService do
  let(:user) { User.create!(name: 'Test User') }
  let!(:sleep1) { Sleep.create!(user_id: user.id, start_time: 2.days.ago, end_time: 2.days.ago + 8.hours) }
  let!(:sleep2) { Sleep.create!(user_id: user.id, start_time: 1.day.ago, end_time: 1.day.ago + 7.hours) }

  let(:valid_params) do
    {
      user_id: user.id,
      start_date: 3.days.ago.to_date,
      end_date: Date.today,
      page: 1,
      per_page: 10
    }
  end

  let(:invalid_params) { valid_params.merge(user_id: 'invalid') }

  describe '#call' do
    context 'with valid params' do
      it 'returns sleep histories and success' do
        result = described_class.new(valid_params).call
        expect(result).to be_success
        expect(result.value).to be_a(Hash)
        expect(result.value).to have_key(:data)
        expect(result.value[:data]).to be_a(ActiveRecord::Relation)
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
