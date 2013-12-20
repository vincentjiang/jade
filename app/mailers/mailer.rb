class Mailer < ActionMailer::Base
  default from: "cacjade@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.welcome_email.subject
  #
  def welcome_email(user)
    @user = user
    mail to: @user.email, subject: "中艺翡翠鉴证系统"
  end

end
