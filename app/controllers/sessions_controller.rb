class SessionsController < ApplicationController
	def new
		@previous_controller = params[:contr]
		@previous_action =  params[:act]
	    session[:val] = nil
	   #Confirmation acc
	    if params[:confirmed]
		      @get_token = params[:confirmed]
		      @identity = Identity.find_by_confirmation_token(@get_token)
		      if @identity.confirmed_at.blank?
			        @identity.update_attribute('confirmed_at',DateTime.now)
		        redirect_to '/sessions/new', notice: "Your account was successfully confirmed.now you can login happily."
		      else
		        redirect_to '/sessions/new', notice: "Already you have activated your account. So please login happily."
	    	  end
	    end
	end

	def create
	    user = User.from_omniauth(env["omniauth.auth"])
		if user.provider == 'facebook' and user.email.blank? and \
        	env["omniauth.auth"] and env["omniauth.auth"]["info"] and env["omniauth.auth"]["info"]["email"]
      		user.update_attribute(:email, env["omniauth.auth"]["info"]["email"])
    	end

		# user from signin/signup
		if params[:email]
     		 @identity = Identity.find_by_email(params[:email])
   		elsif params[:auth_key]
      		@identity = Identity.find_by_email(params[:auth_key])
   		end

		session[:val] = nil
		
		#######  Generating conformation token #######
		if user.provider == 'identity' && @identity.confirmation_token.blank? && @identity.confirmed_at.blank?
	      name= params[:name]
	      email=params[:email]
	      password = params[:password]
	      random_token = SecureRandom.urlsafe_base64
	      @identity.update_attribute('confirmation_token',random_token)
      	  token = @identity.confirmation_token
      	  UserMailer.send_confirmation_email(name,email,token, password).deliver
		  redirect_to '/sessions/new', notice: "You will receive an email with instructions about how to confirm your account in a few minutes."
		elsif  user.provider == 'identity' && !@identity.confirmation_token.blank? && @identity.confirmed_at.blank?
      		redirect_to request.referer, notice: "Your account was not activated yet. Please confirm your account from confirmation email."
    	else
      		session[:user_id] = user.id
			redirect_to '/', notice: "Signed in!" and return # changed the dashboard page to landing page
		end
	end		
		
	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "Signed out!"
	end
	
	def failure
		redirect_to '/sessions/new', alert: "Authentication failed, please try again."
	end
end
