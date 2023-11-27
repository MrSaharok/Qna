class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:destroy]


  def new; end

  def show; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      @answers = @question.answers
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
    redirect_to question_path
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:question).permit(:title, :body)
  end
end
