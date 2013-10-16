class Video < ActiveRecord::Base
	require 'uri'
	require 'file_size_validator'
  attr_accessible :user_id, :video_hivecoins, :video_pic, :video_title, :video_url, :video_pic_cache, :remove_video_pic
  mount_uploader :video_pic, VideopicUploader
  belongs_to :user
  has_many :statistics, dependent: :destroy
  has_many :awarding_hivecoins, dependent: :destroy
  validates :video_pic,  
    :file_size => { 
      :maximum => 0.003.megabytes.to_i 
    } 
  
    def embed(width = "300" , height = "182")
    #iframe code should be the same for vimeo and youtube
    embed_code = "<iframe width='#{width}' height='#{height}' src='#{url}' frameborder='0' allowfullscreen></iframe>"
  end

  private

  def url
    url = nil
    case base_uri
      when "www.youtube.com" , "youtu.be"
        url = "http://www.youtube.com/embed/"+ video_id + '?' + "rel=0"
      when "www.vimeo.com" , "vimeo.com"
        url = "http://player.vimeo.com/video/" + video_id
    end

    url    
  end

  def video_id
    video_id = nil
    case base_uri
      when "www.youtube.com"
        video_id = @uri.query.split('=')[1].slice(0, 11)
      when "youtu.be"
        video_id = @uri.path.delete('/')
      when "www.vimeo.com" , "vimeo.com"
        video_id = @uri.path.delete('/')
      end
    video_id
  end

  def base_uri
    @uri ||= parse_it

    @uri.host
  end
  
  def parse_it
      @uri = URI.parse( code )
  end
end
