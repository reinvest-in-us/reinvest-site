class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV.fetch('BASIC_AUTH_NAME', 'admin'),
                               password: ENV.fetch('BASIC_AUTH_PASSWORD', 'password') if ENV.fetch('BASIC_AUTH_ENABLED', false)

  respond_to :html

  helper_method :body_classes

  def body_classes; end
end
