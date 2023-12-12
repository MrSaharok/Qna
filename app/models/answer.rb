class Answer < ApplicationRecord
  before_update :set_best

  belongs_to :question
  belongs_to :user

  has_many_attached :files

  validates :body, presence: true

  def set_best
      return unless best?
      question.answers.where.not(id: id).update_all(best: false)
  end
end
