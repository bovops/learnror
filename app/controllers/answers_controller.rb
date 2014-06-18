class AnswersController < InheritedResources::Base
  respond_to :js
  actions :create, :update, :destroy
  before_action :authenticate_user!, only: [:create, :destroy]
  custom_actions resource: :accept
  belongs_to :question

  def accept
    resource.accept
  end

  protected

  def create_resource(object)
    object.user = current_user
    super
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
