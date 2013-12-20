class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize

  private

  	def authorize
      if User.count.zero?
        User.create(email: "admin@admin.com", password: "999999", password_confirmation: "999999", ename: "Administrator", cname: "超级管理员", etitle: "Administrator", ctitle: "超级管理员", role: "管理员")
      end
  		unless User.find(session[:user_id])
  			redirect_to login_path, alert: "请登录"
  		end
  	end

    def is_admin
      unless User.find_by_id(session[:user_id]).role == "管理员"
        redirect_to index_path, alert: "您不是管理员"
      end
    end

end
