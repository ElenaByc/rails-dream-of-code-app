# Question 1
# Finish Task 1: Collect emails for students in the current Intro course

# NOTE: The assignment refers to students "currently enrolled" but specifies the Spring 2025 course.
# As of July 2025, Spring has passed and Summer is the current trimester
# Since there is no enrollment for the Summer 2025 Intro to Programming course,
# I followed the instructions as written and used Spring 2025 to target the course and enrolled students.

# Find the Spring 2025 trimester
target_trimester = Trimester.find_by(term: 'Spring', year: '2025')

# Find the Intro to Programming coding class
target_class = CodingClass.find_by(title: 'Intro to Programming')

# Find the course by the trimester and class
course = Course.find_by(trimester_id: target_trimester.id, coding_class_id: target_class.id)

# Get students enrolled in that course
enrollments = Enrollment.where(course_id: course.id)
if enrollments.empty?
  puts "No students enrolled in #{target_trimester.term} #{target_trimester.year} #{target_class.title} course."
else
  enrollments.take(2).each do |enrollment|
    student = enrollment.student
    puts "#{student.id}, #{student.email}"
  end
end

# Question 2
# Task 2: Email all mentors who have not assigned a final grade

# Find the Spring 2025 trimester
target_trimester = Trimester.find_by(term: 'Spring', year: '2025')

# Find the Intro to Programming coding class
target_class = CodingClass.find_by(title: 'Intro to Programming')

# Find the course by the trimester and class
course = Course.find_by(trimester_id: target_trimester.id, coding_class_id: target_class.id)

# Find enrollments with missing final grades
incomplete_enrollments = Enrollment.where(course_id: course.id, final_grade: nil)

# No grading reminders needed
if incomplete_enrollments.empty?
  puts 'There are no enrollments without final grades for ' \
  "#{target_class.title} (#{target_trimester.term} #{target_trimester.year})."
else
  # Find mentor assignments tied to those enrollments
  mentor_assignments = MentorEnrollmentAssignment.where(enrollment_id: incomplete_enrollments.map(&:id))

  # Load mentors via those assignments
  mentors = Mentor.where(id: mentor_assignments.map(&:mentor_id)).uniq

  # Output two mentors who need to finish grading
  puts 'Two mentors who have not assigned a final grade:'
  mentors.take(2).each do |mentor|
    puts "#{mentor.id}, #{mentor.email}"
  end
end
