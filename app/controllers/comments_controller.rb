class CommentsController < InheritedResources::Base
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  actions :create, :update, :destroy
  belongs_to :question, :answer, polymorphic: true
  respond_to :js
  before_action only: [:update, :destroy] do
    check_permissions(resource)
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
