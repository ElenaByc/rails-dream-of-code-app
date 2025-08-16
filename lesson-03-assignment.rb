# 1. What tables do you need to add? Decide on table names and their associations to each other and any existing tables/models.
#
# We need to add two new tables:
# - topics — to store each topic (e.g., "SQL", "CSS", etc.)
# - lesson_topics — a join table to connect lessons and topics
#
# Associations:
# - A Topic has many lessons through lesson_topics
# - A Lesson has many topics through lesson_topics
# This is a many-to-many relationship.


# 2. What columns are necessary for the associations you decided on?
#
# topics table:
#  - id:integer
#  - title:string
#
# lesson_topics table:
#  - id:integer
#  - lesson_id:integer
#  - topic_id:integer

# 3. What other columns (if any) need to be included on the tables? What other data needs to be stored?
#
# For the topics table, we might want to add:
#  - description:string (to provide more context about the topic)
#  - created_at / updated_at :datetime (to track when the topic was created or updated)
# 
# For lesson_topics:
# This is a pure join table. We don’t need any extra columns unless we want to track metadata like:
#   - created_at :datetime (when the association was created)


# 4. Write out each table's name and column names with data types.
# 
# topics table:
# - id:integer
# - title:string
# - created_at:datetime
# - updated_at:datetime
#
# lesson_topics table:
# - id:integer
# - lesson_id:integer
# - topic_id:integer
# - created_at:datetime
# - updated_at:datetime

# 5. Determine the generator command you'll need to create 
# the migration file and run the command to generate the empty migration file
# 
# bin/rails generate migration create_topics
