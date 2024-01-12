class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit destroy update ]

  after_action :publish_question, only: :create

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.new
    @comment = Comment.new
  end

  def new
    @question = Question.new
    @question.links.new
    @question.build_reward
  end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      reward = @question.reward.present? ? ' with reward' : ' without reward'
      flash[:notice] = 'Your question successfully created #{reward}'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if current_user.author_of? @question
      flash[:notice] = 'Your question successfully updated'
      @question.update(question_params)
    end
  end

  def destroy
    if current_user.author_of? @question
      flash[:notice] = 'Your question successfully deleted'
      @question.destroy
    end

    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
    gon.question_id = @question.id
    gon.question_user_id = @question.user_id
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                     links_attributes: [:name, :url, :_destroy],
                                     reward_attributes: [:title, :image])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast('questions', question: @question)
  end
end
