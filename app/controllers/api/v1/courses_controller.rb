class Api::V1::CoursesController < ApplicationController
  def index
    current_trimester = Trimester
      .where("start_date <= ?", Date.today)
      .where("end_date >= ?", Date.today)
      .first

    courses = current_trimester ? current_trimester.courses.includes(:coding_class, :trimester) : []

    course_hashes = courses.map do |course|
      trimester = course.trimester
      {
        id: course.id,
        title: course.coding_class.title,
        application_deadline: trimester.application_deadline.to_s,
        start_date: trimester.start_date.to_s,
        end_date: trimester.end_date.to_s
      }
    end

    render json: { courses: course_hashes }, status: :ok
  end
end

