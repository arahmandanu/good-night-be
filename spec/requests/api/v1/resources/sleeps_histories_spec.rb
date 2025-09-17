require 'rails_helper'

describe V1::Resources::SleepsHistories::SleepsHistories, type: :request do
  let(:user) { User.create!(name: 'Test User') }

  describe 'GET /api/v1/sleeps_histories/:user_id/me' do
    it 'returns sleep histories for user' do
      get "/api/v1/sleeps_histories/#{user.id}/me", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data')
    end
  end

  describe 'GET /api/v1/sleeps_histories/:user_id/followed' do
    it 'returns sleep histories for followed users' do
      get "/api/v1/sleeps_histories/#{user.id}/followed", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data')
    end
  end
end
