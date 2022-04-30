require 'rails_helper'

RSpec.describe 'Api::Doctors', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/doctors/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/api/doctors/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/doctors/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/api/doctors/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /delete' do
    it 'returns http success' do
      get '/api/doctors/delete'
      expect(response).to have_http_status(:success)
    end
  end
end
