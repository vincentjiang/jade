class PasswordController < ApplicationController
  def new
  end

  def udpate
  	user_email = User.find(session[:user_id]).email
  	if user = User.authenticate(user_email, params[:password_current])
  		if params[:password_new] == params[:password_new_confirmation]
  			user.password = params[:password_new]
  			if user.save
  				session[:user_id] = nil
  				redirect_to login_path, notice: "Your password update successfully, please login again."
  			else
  				redirect_to password_path, alert: "something wrong happend, please try again."
  			end
  		else
  			redirect_to password_path, alert: "Verify password is not equal to new password!"
  		end
  	else
  		redirect_to password_path, alert: "Your current password is wrong!"
  	end
  end
end
