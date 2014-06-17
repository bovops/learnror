class QuestionsController < InheritedResources::Base
  skip_load_and_authorize_resource :only => [:new, :create]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :build_answer, only: :show
  respond_to :html
  respond_to :js, only: :update
  actions :all, except: [:edit]

  protected

  def build_answer
    @answer = resource.answers.build
  end

  def create_resource(object)
    object.user = current_user
    super
  end

  def question_params
    params.require(:question).permit(:title, :body, :tag_list, attachments_attributes: [:id, :file, :_destroy])
  end
end
