class UsersController < ApplicationController

		#######  Edit User #######
	def edit
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  @user = User.find(@current_user.id)
	end
  		#######  Edit User #######
	
	#######  Update User #######
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to '/user_profile', notice: "Profile has successfully updated"
		else
			redirect_to '/user_profile'
		end
	end

	#######  Change Password #######
	def change_password 
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		if @current_user.provider == 'identity'
			@identity = Identity.find(@current_user.uid)
		end
	end
	#######  Change Password #######

	#######  Password Update #######
	def update_password
		@identity = Identity.find(params[:id])
		@identity.password_digest = BCrypt::Password.create(params[:password])
		if @identity.save
			redirect_to '/user_profile', notice: "Password has successfully changed"
		else
			redirect_to '/change_password', alert: "There is a problem , Please try again"
		end
	end
  #######  Password Update #######
	
	############### Forgot Password ###################

	 def changepass
	   if params[:reset_password_token] && real_token?(params[:reset_password_token])
		 @identity = Identity.find_by_reset_token(params[:reset_password_token])
		 @user = User.find_by_uid(@identity.id.to_s)
		#render :text => @user.id.inspect and return
		elsif params[:id]
		 @user = User.find(params[:id])
		   #render :text => params.inspect and return
		end
	  end

	def forgotpass
	end


	  def reset
       @identity = Identity.find_by_email(params[:email]) 
       
       if params[:email].blank?
       
       redirect_to request.referer , :notice => "Please enter email"
       elsif @identity
       # generate random token to send along with email
       @email = @identity.email 
       random_token = SecureRandom.urlsafe_base64  #SecureRandom.base64(15).tr('+/=', '0aZ').strip.delete("\n")
       @identity.reset_token = random_token
       @identity.save!
       @token = @identity.reset_token
       UserMailer.reset_pwd_mail(@email,@token).deliver
            respond_to do |format|
              format.html{ redirect_to request.referer , :notice => "You will receive an email with instructions about how to reset your password"}
              format.js{render :nothing => true }
            end
       else
            respond_to do |format|
              format.html{ redirect_to request.referer , :notice => "Email doesn't exist in our database"}
              format.js{render :nothing => true }
            end
       end
  end

	  def change
   	 #render :text => params.inspect and return
	   @user = User.find(params[:id])
		if @user.provider == 'identity'
		  user_id = Identity.find(@user.uid)
		  unencrypted_pwd = params[:password].to_s

		  password_digest = BCrypt::Password.create(unencrypted_pwd)
		  user_id.password_digest = password_digest
		  
		  #secure sake again reset token i.e expire as changed
		   change_token = SecureRandom.urlsafe_base64
		   user_id.reset_token = change_token
		  
		  respond_to do |format|
		    if user_id.save!
		      if current_user
		     
		      format.html {redirect_to '/logout' , notice: 'Your password has been changed'}
		      else
		      format.html {redirect_to root_path , notice: 'Your password has been changed'}
		      end
		    else
		      format.html{ redirect_to user_id , alert: 'Something went wrong!' }
		      format.json{ render json: user_id.errors, status: :unprocessable_entity }
		    end
		  end
		else
		  redirect_to root_path , notice: 'Your account is a linked account.'
		end
  	end



	def user_profile
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
		@user = User.find(@current_user.id)
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
		if @current_user.provider == 'identity'
			@identity = Identity.find(@current_user.uid)
		end
	end

	def user_videos
		@api = Embedly::API.new(:key => 'd3f1d48b58d94330b206f80a2ab72181')
	end
	
	def user_hivecoins
		@videos = current_user.videos.all
	end

	def user_contributed_videos
		@contributed_videos = current_user.awarding_hivecoins.all
	end

	private
  
  def real_token?(token)
     @mytoken = token
       if Identity.find_by_reset_token(@mytoken)
          return true
       else
          return false
       end
  end
  helper_method :real_token? 

end
