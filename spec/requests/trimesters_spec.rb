require 'rails_helper'

RSpec.describe 'Trimesters', type: :request do
  describe 'GET /trimesters/:id/edit' do
    before do
      @trimester = Trimester.create!(
        term: 'Fall',
        year: '2025',
        start_date: Date.new(2025, 9, 1),
        end_date: Date.new(2025, 12, 15),
        application_deadline: Date.new(2025, 8, 15)
      )
    end

    it 'displays the application deadline label' do
      get edit_trimester_path(@trimester)
      expect(response.body).to include('Application deadline')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH /trimesters/:id' do
    before do
      @trimester = Trimester.create!(
        term: 'Fall',
        year: '2025',
        start_date: Date.new(2025, 9, 1),
        end_date: Date.new(2025, 12, 15),
        application_deadline: Date.new(2025, 8, 15)
      )
    end

    it 'updates the application deadline when given a valid date' do
      patch trimester_path(@trimester), params: {
        trimester: { application_deadline: '2025-08-20' }
      }

      expect(response).to have_http_status(:found) # 302 redirect
      follow_redirect!
      expect(response.body).to include('Application deadline updated successfully.')
      expect(@trimester.reload.application_deadline).to eq(Date.new(2025, 8, 20))
    end

    it 'returns 400 when application deadline is blank' do
      patch trimester_path(@trimester), params: {
        trimester: { application_deadline: '' }
      }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include("Application deadline cannot be blank")
    end

    it 'returns 400 when application deadline is not a valid date' do
      patch trimester_path(@trimester), params: {
        trimester: { application_deadline: 'not-a-date' }
      }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('Application deadline must be a valid date')
    end

    it 'returns 404 when the trimester does not exist' do
      patch trimester_path(-1), params: {
        trimester: { application_deadline: '2025-08-20' }
      }

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Trimester not found')
    end

  end
end