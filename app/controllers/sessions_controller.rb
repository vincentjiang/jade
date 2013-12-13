class SessionsController < ApplicationController
  skip_before_filter :authenticate, only: [:new, :create]
  def new
  end

  def create
  	if user = User.authenticate(params[:email], params[:password])
  		session[:user_id] = user.id
  		redirect_to index_path, notice: "Welcome, time now is #{Time.new}"
  	else
  		redirect_to login_path, alert: "Invalide login infomation, please input correctly"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_path, notice: "If you want to login again, please input email and password"
  end
end
