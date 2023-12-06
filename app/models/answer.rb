class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  default_scope { order(best: :desc).order(created_at: :asc) }

  def set_best!
    transaction do
      question.answers.lock!.update_all(best: false)
      update!(best: true)
    end
  end
end
