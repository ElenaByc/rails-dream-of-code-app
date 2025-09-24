# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      # Create test data for the current and upcoming trimesters
      # Define current_trimester
      @current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      # Define upcoming_trimester
      upcoming_start = @current_trimester.end_date + 7.days
      @upcoming_trimester = Trimester.create!(
        term: 'Upcoming term',
        year: upcoming_start.year.to_s,
        start_date: upcoming_start,
        end_date: upcoming_start + 2.months,
        application_deadline: upcoming_start - 15.days
      )
    end

    it 'returns a 200 OK status' do
      # Send a GET request to the dashboard route
      get '/dashboard'

      # Check that the response status is 200 (OK)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get '/dashboard'
      expect(response.body).to include("#{@current_trimester.term} - #{@current_trimester.year}")
    end

    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include("#{@upcoming_trimester.term} - #{@upcoming_trimester.year}")
    end

    it 'displays links to the courses in the upcoming trimester' do
    end
  end
end
