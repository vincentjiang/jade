class User < ActiveRecord::Base

	attr_reader :password
	attr_accessor :password_confirmation
	validates_presence_of :email, :password, :password_confirmation , on: :create, message: "不能为空"
	validates_confirmation_of :password, on: :create, message: "应该一致"
	validates_uniqueness_of :email, on: :create, message: "登录名不能重复"

	def User.authenticate(email, password)
		if user = User.find_by_email(email)
			if user.hashed_password == encrypt_password(password, user.salt)
				user
			end
		end
	end

	def User.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "VincentJiang" + salt)
	end

	#'password' is a virtual attribute
	def password=(password)
		@password = password

		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end

	private

		def generate_salt
			self.salt = self.object_id.to_s + rand.to_s
		end
		
end
