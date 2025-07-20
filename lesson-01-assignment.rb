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


