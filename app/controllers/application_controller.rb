class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  private
  	def authenticate
  		unless User.find(session[:user_id])
  			redirect_to login_path, alert: "Please login ..."
  		end
  	end
end
