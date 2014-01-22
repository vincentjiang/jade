class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  def new
  end

  def create
  	if user = User.authenticate(params[:email], params[:password])
  		session[:user_id] = user.id
  		redirect_to index_path, notice: "您好！本次登录时间为：#{Time.new.strftime('%Y-%m-%d %H:%M:%S').to_s}"
  	else
  		redirect_to login_path, alert: "Invalide login infomation, please input correctly"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_path, notice: "If you want to login again, please input email and password"
  end
end
