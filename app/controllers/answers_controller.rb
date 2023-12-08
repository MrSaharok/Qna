class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[show new create]
  before_action :load_answer, only: %i[show edit update destroy]


  def new
    @answer = Answer.new
  end

  def show; end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
  end

  def update
    @answer.update(answer_params)
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question) }
      format.js
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :best)
  end
end

