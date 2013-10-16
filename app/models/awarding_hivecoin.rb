class AwardingHivecoin < ActiveRecord::Base
  attr_accessible :hivecoin, :user_id, :video_id
	belongs_to :video
	belongs_to :user
end
