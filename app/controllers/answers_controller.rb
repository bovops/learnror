class AnswersController < InheritedResources::Base
  respond_to :js
  actions :create, :update, :destroy
  before_action :authenticate_user!, only: [:create, :destroy]

  belongs_to :question


  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
