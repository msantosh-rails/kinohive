class AwardingHivecoinsController < ApplicationController
  # GET /awarding_hivecoins
  # GET /awarding_hivecoins.json
	def awarding_hivecoin
		@awarding_hivecoin = AwardingHivecoin.new
		@awarding_hivecoin.hivecoin = params[:id]
		@awarding_hivecoin.video_id = params[:videoid]
		@awarding_hivecoin.user_id = current_user.id


		#For video table
		@video = Video.find(params[:videoid])
		@video.update_attributes(:video_hivecoins => @video.video_hivecoins.to_i + params[:id].to_i)


		#For User table
		if !@video.user_id.blank?
			@awarded_video = User.find(@video.user_id)
			@awarded_video.update_attributes(:total_hivecoins => @video.video_hivecoins.to_i + @awarded_video.total_hivecoins.to_i)
		current_user.update_attributes(:total_hivecoins => current_user.total_hivecoins.to_i - params[:id].to_i)
		else
			@awarded_video = Admin.find(1)
			@awarded_video.update_attributes(:admin_hivecoins => @video.video_hivecoins.to_i + @awarded_video.admin_hivecoins.to_i)
		current_user.update_attributes(:total_hivecoins => current_user.total_hivecoins.to_i - params[:id].to_i)
		end
		@awarding_hivecoin.save
		render :partial => "hivecoin_count.html.erb"
	end

end
