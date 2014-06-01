class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_commentable, only: [:create]
  before_action :load_comment, only: [:destroy, :update]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @commentable = @comment.commentable
    @comment.update(comment_params) if @comment.user == current_user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private


  def set_commentable
    parent ||= %w(answer question).find {|p| params.has_key?("#{p}_id")}
    @commentable ||= parent.classify.constantize.find(params["#{parent}_id"])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
