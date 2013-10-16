class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authorize
  
  	redirect_to '/sessions/new', alert: "Please log in first!" unless current_user || current_admin
  
  end

  def record_visit
		if request.fullpath == '/'
			if cookies['application-visited']
    			return
  			else
   			 cookies['application-visited'] = true
				if current_user
					Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code, user_id: current_user.id )
				else
					Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code)
				end
#    Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code)
  			end
		else 
			if cookies['video-visited']
    			return
  			else
   			 cookies['video-visited'] = true
				if current_user
					Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code, user_id: current_user.id )
				else
					Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code)
				end
#    Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code)
  			end
		end
#		if current_user
#	    	Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code, user_id: current_user.id )
#		else
#			Visit.create(page: request.fullpath, ip_address: request.ip, location: request.location.country_code)
#		end
  end
  
  private
  
  	def current_user
    		
    		@current_user ||= User.find(session[:user_id]) if session[:user_id]
    		
  	end
	helper_method :current_user
end
