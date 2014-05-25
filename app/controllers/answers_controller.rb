class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :load_question, only: [:create, :update, :destroy]
  before_action :load_answer, only: [:update, :destroy]


  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @answer.update(answer_params) if @answer.user == current_user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
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
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
