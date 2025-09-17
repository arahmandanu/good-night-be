require 'rails_helper'

RSpec.describe Follow::ActorRemoveFollowService do
  let(:user) { User.create!(name: 'Test User') }
  let(:followed) { User.create!(name: 'Followed User') }
  let!(:follow_record) { UserFollow.create!(user_id: user.id, followed_id: followed.id) }

  describe '#call' do
    context 'with valid user and followed_id' do
      it 'removes the follow record and returns success' do
        result = described_class.new(user_id: user.id, followed_id: followed.id).call
        expect(result).to be_success
        expect(result.value).to eq('Successfully unfollow user')
        expect(UserFollow.find_by(user_id: user.id, followed_id: followed.id)).to be_nil
      end
    end

    context 'when follow record does not exist' do
      it 'returns failure with not found message' do
        follow_record.destroy
        result = described_class.new(user_id: user.id, followed_id: followed.id).call
        expect(result).to be_failure
        expect(result.error).to eq('Follow record not found').or respond_to(:errors)
      end
    end

    context 'with invalid params' do
      it 'returns failure with contract errors' do
        result = described_class.new(user_id: nil, followed_id: nil).call
        expect(result).to be_failure
        expect(result.error).to respond_to(:errors)
      end
    end
  end
end
