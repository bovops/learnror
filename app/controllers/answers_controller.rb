class AnswersController < ApplicationController

  before_action :load_question, only: [:create, :update]
  before_action :authenticate_user!, only: [:new, :create]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params) if @answer.user == current_user
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
