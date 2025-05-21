class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :basic_auth_required?

  private

  def basic_auth
    Rails.logger.info "BASIC_AUTH_USER: #{ENV["BASIC_AUTH_USER"]}, BASIC_AUTH_PASSWORD: #{ENV["BASIC_AUTH_PASSWORD"]}"
    authenticate_or_request_with_http_basic do |username, password|
      Rails.logger.info "input username: #{username}, input password: #{password}"
      [username, password].map { _1.to_s.strip } == [ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"]].map { _1.to_s.strip }
    end
  end

  def basic_auth_required?
    Rails.env.development? || Rails.env.production?
  end
end
