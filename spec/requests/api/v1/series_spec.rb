require 'rails_helper'

RSpec.describe 'Series API', type: :request do
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

  describe 'GET /api/v1/series' do
    context 'when no filter param is sent' do
      before do
        create_list(:serie, 5, user_id: user.id)
        get '/api/v1/series', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns 5 series from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end
  end

  describe 'GET /api/v1/series/:id' do
    let(:serie) { create(:serie, user_id: user.id) }

    before { get "/api/v1/series/#{serie.id}", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the json for serie' do
      expect(json_body[:data][:attributes][:imdb]).to eq(serie.imdb)
    end
  end

  describe 'POST /api/v1/series' do
    let(:serie_params) { attributes_for(:serie) }

    before do
      post '/api/v1/series/', params: { serie: serie_params }.to_json, headers: headers
    end

    context 'when the params are valid' do

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the serie in the database' do
        expect( Serie.find_by(imdb: serie_params[:imdb]) ).not_to be_nil
      end

      it 'returns the json for created serie' do
        expect(json_body[:data][:attributes][:imdb]).to eq(serie_params[:imdb])
      end

      it 'assigns the created serie to the current user' do
        expect(json_body[:data][:attributes][:'user-id'].to_i).to eq(user.id)
      end
    end

    context 'when the params are invalid' do
      let(:serie_params) { attributes_for(:serie, imdb: ' ') }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'doesn\'t saves the serie in the database' do
        expect( Serie.find_by(imdb: serie_params[:imdb]) ).to be_nil
      end

      it 'returns the json error for imdb' do
        expect(json_body[:errors]).to have_key(:imdb)
      end
    end
  end

  describe 'PUT /api/v1/series/:id' do
    let(:serie) { create(:serie, user_id: user.id) }

    before do
      put "/api/v1/series/#{serie.imdb}", params: { serie: serie_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:serie_params) { { imdb: 'tt0848228' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the json for updated serie' do
        expect(json_body[:data][:attributes][:imdb]).to eq(serie_params[:imdb])
      end

      it 'updates the serie in the database' do
        expect( Serie.find_by(imdb: serie_params[:imdb]) ).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:serie_params) { { imdb: ' ' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the json error for imdb' do
        expect(json_body[:errors]).to have_key(:imdb)
      end

      it 'doesn\'t updates the imdb in the database' do
        expect( Serie.find_by(imdb: serie_params[:imdb]) ).to be_nil
      end
    end
  end

  describe 'DELETE /api/v1/series/:id' do
    let(:serie) { create(:serie, user_id: user.id) }

    before do
      delete "/api/v1/series/#{serie.imdb}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'removes the task from the database' do
      expect { Serie.find(serie.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end