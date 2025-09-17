require 'rails_helper'

RSpec.describe SleepsHistories::ActorGetListFollowedContract do
  let(:valid_uuid) { SecureRandom.uuid }
  let(:valid_params) do
    {
      user_id: valid_uuid,
      start_date: Date.today,
      end_date: Date.today,
      page: 1,
      per_page: 10
    }
  end

  it 'is valid with correct params' do
    contract = described_class.new.call(valid_params)
    expect(contract).to be_success
  end

  it 'fails with invalid user_id' do
    contract = described_class.new.call(valid_params.merge(user_id: 'invalid'))
    expect(contract.errors[:user_id]).to include('must be a valid UUID')
  end

  it 'fails with negative page' do
    contract = described_class.new.call(valid_params.merge(page: -1))
    expect(contract.errors[:page]).to include('must be a positive integer')
  end

  it 'fails with negative per_page' do
    contract = described_class.new.call(valid_params.merge(per_page: 0))
    expect(contract.errors[:per_page]).to include('must be a positive integer')
  end

  it 'fails with invalid start_date' do
    contract = described_class.new.call(valid_params.merge(start_date: 'not-a-date'))
    expect(contract.errors[:start_date]).to include('must be a date')
  end

  it 'fails with invalid end_date' do
    contract = described_class.new.call(valid_params.merge(end_date: 'not-a-date'))
    expect(contract.errors[:end_date]).to include('must be a date')
  end
end
