class Api::V1::EnrollmentsController < ApplicationController
  def index
    course = Course.find(params[:course_id])
    enrollments = course.enrollments.includes(:student)

    enrollment_hashes = enrollments.map do |enrollment|
      student = enrollment.student
      {
        id: enrollment.id,
        studentId: student.id,
        studentFirstName: student.first_name,
        studentLastName: student.last_name,
        finalGrade: enrollment.final_grade.to_s
      }
    end

    render json: { enrollments: enrollment_hashes }, status: :ok
  end
end



