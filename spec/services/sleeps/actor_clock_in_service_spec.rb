require 'rails_helper'

RSpec.describe Sleeps::ActorClockInService do
  let(:user) { User.create!(name: 'Test User') }

  describe '#call' do
    context 'with valid user' do
      it 'clocks in and returns success' do
        result = described_class.new(user.id).call
        expect(result).to be_success
        expect(result.value).to include('user_id' => user.id, 'start_time' => kind_of(String))
      end
    end

    context 'with invalid user' do
      it 'returns failure with user not found' do
        result = described_class.new('invalid-id').call
        expect(result).to be_failure
        expect(result.error).to eq('User not found').or respond_to(:errors)
      end
    end
  end
end
