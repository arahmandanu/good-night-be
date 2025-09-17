require 'rails_helper'

RSpec.describe Follow::ActorAddFollowService do
  let(:user) { User.create!(name: 'Test User') }
  let(:followed) { User.create!(name: 'Followed User') }

  describe '#call' do
    context 'with valid user and followed_id' do
      it 'creates a follow record and returns success' do
        result = described_class.new(user_id: user.id, followed_id: followed.id).call
        expect(result).to be_success
        expect(result.value).to eq('Successfully followed user')
        expect(UserFollow.find_by(user_id: user.id, followed_id: followed.id)).to be_present
      end
    end

    context 'with invalid params' do
      it 'returns failure with contract errors' do
        result = described_class.new(user_id: nil, followed_id: nil).call
        expect(result).to be_failure
        expect(result.error).to respond_to(:errors)
      end
    end

    context 'when user not found' do
      it 'returns failure with user not found message' do
        result = described_class.new(user_id: 'non-existent-id', followed_id: followed.id).call
        expect(result).to be_failure
        expect(result.error).to eq('User not found').or respond_to(:errors)
      end
    end

    context 'when followed user not found' do
      it 'returns failure with user not found message' do
        result = described_class.new(user_id: user.id, followed_id: 'non-existent-id').call
        expect(result).to be_failure
        expect(result.error).to eq('User not found').or respond_to(:errors)
      end
    end
  end
end
