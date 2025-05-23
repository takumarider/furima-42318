class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :basic_auth_required?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    Rails.logger.info "BASIC_AUTH_USER: #{ENV["BASIC_AUTH_USER"]}, BASIC_AUTH_PASSWORD: #{ENV["BASIC_AUTH_PASSWORD"]}"
    authenticate_or_request_with_http_basic do |username, password|
      Rails.logger.info "input username: #{username}, input password: #{password}"
      [username, password].map { _1.to_s.strip } == [ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"]].map { _1.to_s.strip }
    end
  end

  def basic_auth_required?
    result = Rails.env.development? || Rails.env.production?
    Rails.logger.info "basic_auth_required? => #{result}, Rails.env: #{Rails.env}"
    result
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date
    ])
  end
end
