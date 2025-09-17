require 'rails_helper'

RSpec.describe Follow::ActorListFollowedService do
  let(:user) { User.create!(name: 'Test User') }
  let(:followed1) { User.create!(name: 'Followed One') }
  let(:followed2) { User.create!(name: 'Followed Two') }
  let!(:follow1) { UserFollow.create!(user_id: user.id, followed_id: followed1.id) }
  let!(:follow2) { UserFollow.create!(user_id: user.id, followed_id: followed2.id) }

  let(:valid_params) { { user_id: user.id, page: 1, per_page: 10 } }
  let(:invalid_params) { { user_id: nil, page: 1, per_page: 10 } }

  describe '#call' do
    context 'with valid params' do
      it 'returns paginated followed users and success' do
        result = described_class.new(params: valid_params).call
        expect(result).to be_success
        expect(result.value).to be_a(Hash)
        expect(result.value).to have_key(:data)
        expect(result.value[:data]).to be_a(ActiveRecord::Relation).or be_a(Array)
      end
    end

    context 'with invalid params' do
      it 'returns failure with contract errors' do
        result = described_class.new(params: invalid_params).call
        expect(result).to be_failure
        expect(result.error).to respond_to(:errors)
      end
    end

    context 'when user not found' do
      it 'returns failure with user not found message' do
        result = described_class.new(params: { user_id: 'non-existent-id', page: 1, per_page: 10 }).call
        expect(result).to be_failure
        expect(result.error).to eq('User not found').or respond_to(:errors)
      end
    end
  end
end
