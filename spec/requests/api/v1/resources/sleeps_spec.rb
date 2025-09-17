require 'rails_helper'

describe V1::Resources::Sleeps::Sleeps, type: :request do
  let(:user) { User.create!(name: 'Test User') }
  let(:sleep) { Sleep.create!(user_id: user.id, start_time: Time.now) }

  describe 'POST /api/v1/sleeps/clock_in' do
    it 'clocks in for a user' do
      post '/api/v1/sleeps/clock_in', params: { user_id: user.id }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('data')
    end
  end

  describe 'POST /api/v1/sleeps/clock_out' do
    it 'clocks out for a user sleep' do
      post '/api/v1/sleeps/clock_out', params: { user_id: user.id, sleep_id: sleep.id }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('data')
    end
  end
end
