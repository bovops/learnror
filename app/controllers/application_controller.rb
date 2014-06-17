class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  load_and_authorize_resource unless: :devise_controller?

  rescue_from CanCan::AccessDenied do
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

end
