require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'mentors exist' do
      before do
        Mentor.create!(first_name: "John", last_name: "Doe", email: "john.doe@example.com", max_concurrent_students: 3)
        Mentor.create!(first_name: "Jane", last_name: "Smith", email: "jane.smith@example.com", max_concurrent_students: 2)
      end

      it 'returns a page containing mentor details' do
        get '/mentors'
        expect(response.body).to include('First name:')
        expect(response.body).to include('John')
        expect(response.body).to include('Last name:')
        expect(response.body).to include('Doe')
        expect(response.body).to include('Email:')
        expect(response.body).to include('john.doe@example.com')
        expect(response.body).to include('Jane')
        expect(response.body).to include('Smith')
        expect(response.body).to include('jane.smith@example.com')
      end
    end

    context 'mentors do not exist' do
      it 'shows the title but no list items' do
        get '/mentors'
        expect(response.body).to include('Mentors')
        expect(response.body).not_to include('<li>')
      end
    end
  end

  describe "GET /mentors/:id" do
    let(:mentor) { Mentor.create!(first_name: "John", last_name: "Doe", email: "john.doe@example.com", max_concurrent_students: 3) }

    it 'returns a page with the mentor details' do
      get "/mentors/#{mentor.id}"
      expect(response.body).to include('First name:')
      expect(response.body).to include('John')
      expect(response.body).to include('Last name:')
      expect(response.body).to include('Doe')
      expect(response.body).to include('Email:')
      expect(response.body).to include('john.doe@example.com')
    end
  end
end