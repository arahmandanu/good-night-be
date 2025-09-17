require 'rails_helper'

RSpec.describe Users::ActorGetDetailService do
  let(:user) { User.create!(name: 'Test User') }

  describe '#call' do
    context 'with valid user id' do
      it 'returns user details and success' do
        result = described_class.new(user.id).call
        expect(result).to be_success
        expect(result.value).to include('id' => user.id, 'name' => user.name)
      end
    end

    context 'with invalid user id' do
      it 'returns failure with not found message' do
        result = described_class.new('non-existent-id').call
        expect(result).to be_failure
        expect(result.error).to eq('User not found').or respond_to(:errors)
      end
    end
  end
end
