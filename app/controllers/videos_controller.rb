class VideosController < ApplicationController
  # GET /videos
  # GET /videos.json
  before_filter :authorize, :except => [:index, :show, :search]
  before_filter :record_visit, :only => [:index, :show] 
  before_filter :count_views
  
  def index
  
    @api = Embedly::API.new(:key => 'd3f1d48b58d94330b206f80a2ab72181')
    @q = Video.search(params[:q])
    @videos = @q.result.order("video_hivecoins DESC")


#    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
      @api = Embedly::API.new(:key => 'd3f1d48b58d94330b206f80a2ab72181')
    @video = Video.find(params[:id])
    if @video.user_id==nil
	
	@videos=Video.where(:user_id=>nil)
	
   else
   
   	@videos=Video.where(:user_id=>@video.user_id)
   end
    
	@statistic = Statistic.new
		if current_user
			@taken_critic = Statistic.find_by_user_id_and_video_id(current_user.id,@video.id)
		end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
  	@api = Embedly::API.new(:key => 'd3f1d48b58d94330b206f80a2ab72181')
    @video = Video.new(params[:video])
    @video.user_id=current_user.id
    
    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: 'Video was successfully Uploaded.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to videos_path, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
  
  def search
  
    @api = Embedly::API.new(:key => 'd3f1d48b58d94330b206f80a2ab72181')
    @q = Video.search(params[:q])
    @videos = @q.result.order("video_hivecoins DESC")
    
  end


  def count_views
	@views = Visit.where(page: request.fullpath).count
#	@non_users = Visit.where(user_id: nil).count
#  	@video_views = Visit.where('page =?', request.fullpath).select('distinct ip_address').count
#		@total_views = 0;
#		@video_views.values.each do |views|
#			@total_views += views.to_i
#		end
#	@total_views += @non_users	
  end
  
end
