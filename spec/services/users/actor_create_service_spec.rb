require 'rails_helper'

RSpec.describe Users::ActorCreateService do
  let(:valid_params) { { name: 'Test User' } }
  let(:invalid_params) { { name: '' } }

  describe '#call' do
    context 'with valid params' do
      it 'creates a user and returns success' do
        result = described_class.new(valid_params).call
        expect(result).to be_success
        expect(result.value).to include('name' => 'Test User')
        expect(User.find_by(name: 'Test User')).to be_present
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
