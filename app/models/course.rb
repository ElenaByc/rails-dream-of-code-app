class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  delegate :title, to: :coding_class

  def student_name_list
    student_names = []
    enrollments_with_students.each do |enrollment|
      student = enrollment.student
      full_name = "#{student.first_name} #{student.last_name}"
      student_names << full_name
    end

    student_names
  end

  def student_email_list
    student_emails = []
    enrollments_with_students.each do |enrollment|
      student = enrollment.student
      student_emails << student.email
    end

    student_emails
  end

  private

  def enrollments_with_students
    enrollments.includes(:student)
  end
end
