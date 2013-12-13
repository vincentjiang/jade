class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  private
  	def authenticate
  		if session[:user_id].nil?
  			redirect_to login_path, alert: "Please login ..."
  		end
  	end
end
