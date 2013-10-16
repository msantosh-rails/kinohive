class AwardingHivecoinsController < ApplicationController
  # GET /awarding_hivecoins
  # GET /awarding_hivecoins.json
  def index
    @awarding_hivecoins = AwardingHivecoin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @awarding_hivecoins }
    end
  end

  # GET /awarding_hivecoins/1
  # GET /awarding_hivecoins/1.json
  def show
    @awarding_hivecoin = AwardingHivecoin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @awarding_hivecoin }
    end
  end

  # GET /awarding_hivecoins/new
  # GET /awarding_hivecoins/new.json
  def new
    @awarding_hivecoin = AwardingHivecoin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @awarding_hivecoin }
    end
  end

  # GET /awarding_hivecoins/1/edit
  def edit
    @awarding_hivecoin = AwardingHivecoin.find(params[:id])
  end

  # POST /awarding_hivecoins
  # POST /awarding_hivecoins.json
  def create
    @awarding_hivecoin = AwardingHivecoin.new
	@awarding_hivecoin.hivecoin = params[:id]
	@awarding_hivecoin.video_id = @video.id
	@awarding_hivecoin.user_id = current_user.id

    respond_to do |format|
      if @awarding_hivecoin.save
        format.html { redirect_to @awarding_hivecoin, notice: 'Awarding hivecoin was successfully created.' }
        format.json { render json: @awarding_hivecoin, status: :created, location: @awarding_hivecoin }
      else
        format.html { render action: "new" }
        format.json { render json: @awarding_hivecoin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /awarding_hivecoins/1
  # PUT /awarding_hivecoins/1.json
  def update
    @awarding_hivecoin = AwardingHivecoin.find(params[:id])

    respond_to do |format|
      if @awarding_hivecoin.update_attributes(params[:awarding_hivecoin])
        format.html { redirect_to @awarding_hivecoin, notice: 'Awarding hivecoin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @awarding_hivecoin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awarding_hivecoins/1
  # DELETE /awarding_hivecoins/1.json
  def destroy
    @awarding_hivecoin = AwardingHivecoin.find(params[:id])
    @awarding_hivecoin.destroy

    respond_to do |format|
      format.html { redirect_to awarding_hivecoins_url }
      format.json { head :no_content }
    end
  end
	
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
