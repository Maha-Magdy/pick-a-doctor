class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # skip_before_action :verify_authenticity_token
  # protect_from_forgery unless: -> { request.format.json? }
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name password password_confirmation email date_of_birth])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name date_of_birth])
  end
  include ActionController::MimeResponds
end
