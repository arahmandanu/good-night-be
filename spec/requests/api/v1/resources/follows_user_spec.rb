require 'rails_helper'

describe V1::Resources::Follows::User, type: :request do
  let(:user) { User.create!(name: 'Test User') }
  let(:followed) { User.create!(name: 'Followed User') }

  describe 'GET /api/v1/user_follows/list' do
    it 'returns list of followed users' do
      get '/api/v1/user_follows/list', params: { user_id: user.id }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data')
    end
  end

  describe 'POST /api/v1/user_follows/add' do
    it 'adds a user to follow' do
      post '/api/v1/user_follows/add', params: { user_id: user.id, followed_id: followed.id }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:created).or have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data')
    end
  end

  describe 'POST /api/v1/user_follows/remove' do
    it 'removes a followed user' do
      # Ensure the user is following 'followed' before removing
      post '/api/v1/user_follows/add', params: { user_id: user.id, followed_id: followed.id }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:created).or have_http_status(:ok)

      # Now test removal
      post '/api/v1/user_follows/remove', params: { user_id: user.id, followed_id: followed.id }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('data')
    end
  end
end
