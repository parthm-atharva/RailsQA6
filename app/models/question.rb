class Question < ApplicationRecord
  belongs_to :user
  has_many :question_topics
  has_many :topics, through: :question_topics
  has_many :answers

  def associate_topic(topic_id)
    self.question_topics.create(topic_id: topic_id) unless self.question_topics.any?
  end
end
