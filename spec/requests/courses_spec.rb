require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses/:id/enrolled_students' do
    before do
      @student = Student.create!(
        first_name: 'Elena',
        last_name: 'Coder',
        email: 'elena@example.com'
      )

      @coding_class = CodingClass.create!(title: 'Test Class')

      @trimester = Trimester.create!(
        year: '2026',
        term: 'Spring',
        start_date: Date.new(2026, 3, 1),
        end_date: Date.new(2026, 5, 31),
        application_deadline: Date.new(2026, 2, 15)
      )

      @course = Course.create!(
        coding_class: @coding_class,
        trimester: @trimester
      )

      Enrollment.create!(student: @student, course: @course)
    end

    it 'displays the course name and enrolled student name' do
      get course_enrolled_students_path(@course)
      expect(response.body).to include(@coding_class.title)
      expect(response.body).to include(@student.full_name)
    end
  end
end
