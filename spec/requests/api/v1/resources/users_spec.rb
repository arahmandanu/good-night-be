require 'rails_helper'

describe V1::Resources::Users::Users, type: :request do
  describe 'GET /api/v1/users/:id/detail' do
    let(:user) { User.create!(name: 'Test User') }

    it 'returns user details' do
  get "/api/v1/users/#{user.id}/detail", headers: { 'ACCEPT' => 'application/json' }
    expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data')
    end
  end

  describe 'POST /api/v1/users' do
    it 'creates a user' do
  post '/api/v1/users', params: { name: 'New User' }, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('data')
    end
  end
end
