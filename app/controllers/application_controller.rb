class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_headers

  private
  def set_headers
    response.headers['Access-Control-Allow-Origin'] = 'http://act.e-mxing.com'
  end
end
