class AddUniqueIndexToLessonTopics < ActiveRecord::Migration[8.0]
  def change
    # Adding a unique index to ensure that each lesson can only be associated with a topic once
    add_index :lesson_topics, [:lesson_id, :topic_id], unique: true
  end
end
