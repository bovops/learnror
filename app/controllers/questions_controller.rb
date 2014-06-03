class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.all
    @question = Question.new
  end

  def show
    @answer = @question.answers.build
    #@answer.attachments.build
  end

  def new
    @question = Question.new
    redirect_to questions_path
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Question successfully created'
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @question.update(question_params) if @question.user == current_user
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
