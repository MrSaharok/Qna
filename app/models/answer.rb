class Answer < ApplicationRecord
  include Votable
  include Commentable

  before_update :set_best

  belongs_to :question
  belongs_to :user
  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  def set_best
    transaction do
      question.answers.where.not(id: id).update_all(best: false)
      question.reward&.update!(user: user)
    end
  end
end
