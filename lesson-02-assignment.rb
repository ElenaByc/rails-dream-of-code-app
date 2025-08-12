# Question 1
# Finish Task 2 from the lesson: For each CodingClass, 
# create a new Course record for that class in the Spring 2026 trimester


# Create Spring 2026 Trimester record with same date structure as Spring 2025
Trimester.create(
  year: '2026',
  term: 'Spring',
  application_deadline: '2026-02-15',
  start_date: '2026-03-01',
  end_date: '2026-05-31'
)

# Find the Spring 2026 trimester to get its ID
trimester = Trimester.find_by(term: 'Spring', year: '2026')

# Find all CodingClass records
coding_classes = CodingClass.all

# Create a Course for each CodingClass in the Spring 2026 trimester
coding_classes.each do |coding_class|
  Course.create(
    coding_class_id: coding_class.id,
    trimester_id: trimester.id,
    max_enrollment: 25
  )
end


#Question 2
# Create a new student record and enroll the student 
# in the Intro to Programming course for the Spring 2026 trimester.
# Find a mentor with no more than 2 students (enrollments) assigned 
# and assign that mentor to your new student's enrollment.

# Create a new student record
student = Student.create(
  first_name: 'John',
  last_name: 'Doe',
  email: 'john.doe@mail.com',
) 

# Find Intro to Programming course for the Spring 2026 trimester
trimester = Trimester.find_by(term: 'Spring', year: '2026')
intro_class = CodingClass.find_by(title: 'Intro to Programming')
course = Course.find_by(coding_class_id: intro_class.id, trimester_id: trimester.id)

# Enroll the student in the Intro to Programming course
enrollment = Enrollment.create(
  student_id: student.id,
  course_id: course.id,
)

# Find a mentor with no more than 2 enrollments assigned
mentor = Mentor
  .joins('LEFT JOIN mentor_enrollment_assignments ON mentor_enrollment_assignments.mentor_id = mentors.id')
  .group('mentors.id')
  .having('COUNT(mentor_enrollment_assignments.id) <= 2')
  .first

# Assign mentor to the new enrollment if one is found
if mentor
  MentorEnrollmentAssignment.create(
    mentor_id: mentor.id,
    enrollment_id: enrollment.id
  )
end

#  Question 3
#
# Project Idea: SkillShowcase – Your Certificate Portfolio
# SkillShowcase is a personal web app that helps users organize and present 
# their professional certificates in a more useful and recruiter-friendly way.
# - A user can add certificates with a title, description, completion date, credential URL, and associated skills.
# - A user can upload the certificate file (PDF or image).
# - A user can create or update an issuer (e.g., Udemy, Coursera) and upload its logo.
# - A user can create or select skills (tags) like "Ruby on Rails" or "Backend" and associate them with certificates.
# - A user can generate a filtered view of certificates by skill and share it via a unique link — perfect 
#   for tailoring their portfolio to a specific job or employer.
#
# Unlike static lists (like LinkedIn’s certificate section), SkillShowcase lets users highlight 
# the most relevant qualifications for each opportunity.

# Question 4 – Data Model Planning (Text-Based ERD)

# User
# - name
# - email
# - passwordd:\Documents\Elena\CTD\04 - Ruby on Rails class\erd.png

# Certificate
# - title
# - description
# - completion date
# - credential URL
# - document (PDF or image)
# - belongs to a user
# - belongs to an issuer
# - has many skills (through certificate_skills)

# Issuer
# - name
# - website URL (optional)
# - logo (image)
# - has many certificates

# Skill
# - name
# - has many certificates (through certificate_skills)

# CertificateSkill (join table)
# - certificate_id
# - skill_id
# - connects certificates and skills
