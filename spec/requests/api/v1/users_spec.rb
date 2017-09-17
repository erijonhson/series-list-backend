require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
    {
        'Content-Type' => Mime[:json].to_s,
        'access-token' => auth_data['access-token'],
        'uid' => auth_data['uid'],
        'client' => auth_data['client']
    }
  end

  describe 'GET /api/v1/auth/validate_token' do

    context 'when the request headers are valid' do
      before do
        get '/api/v1/auth/validate_token', params: {}, headers: headers
      end

      it 'returns the user id' do
        expect(json_body[:data][:id].to_i).to eq(user.id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request headers are invalid' do
      before do
        headers['access-token'] = 'invalide'
        get '/api/v1/auth/validate_token', params: {}, headers: headers
      end

      it 'returns status 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end