require 'rails_helper'

RSpec.describe Sleeps::ActorClockOutService do
  let(:user) { User.create!(name: 'Test User') }
  let!(:sleep_record) { Sleep.create!(user_id: user.id, start_time: 1.hour.ago, end_time: nil) }

  describe '#call' do
    context 'with valid user and active sleep' do
      it 'clocks out and returns success' do
        result = described_class.new(user.id, sleep_record.id).call
        expect(result).to be_success
        expect(result.value).to include('id' => sleep_record.id, 'end_time' => kind_of(String))
      end
    end

    context 'with invalid user' do
      it 'returns failure with user not found' do
        result = described_class.new('invalid-id', sleep_record.id).call
        expect(result).to be_failure
        expect(result.error).to eq('User not found').or respond_to(:errors)
      end
    end

    context 'with no active sleep session' do
      it 'returns failure with no active sleep session found' do
        sleep_record.update!(end_time: Time.current)
        result = described_class.new(user.id, sleep_record.id).call
        expect(result).to be_failure
        expect(result.error).to eq('No active sleep session found').or respond_to(:errors)
      end
    end
  end
end
