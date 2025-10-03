class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :mentor_enrollment_assignments
  has_many :submissions

  def student_name
    "#{student.first_name} #{student.last_name}"
  end
end
