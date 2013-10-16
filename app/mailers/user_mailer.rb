require 'action_mailer'
class UserMailer < ActionMailer::Base
  default from: "info@kinohive.com"
  ####### Send confirmation email #######
  def send_confirmation_email(name,email,token, password)
    @name = name.to_s.capitalize
    @password = token
    @email =  email
	@new_password = password
    mail(:from => "info@kinohive.com<info@kinohive.com>", :to => @email, :subject => "Kinohive- Account Confirmation")
  end

  def reset_pwd_mail(myemail,mytoken) 
    @pwd_email = myemail
    @token = mytoken
     mail(:from => "info@kinohive.com<info@kinohive.com>", :to => @pwd_email, :subject => "Change your password")
  end

end
