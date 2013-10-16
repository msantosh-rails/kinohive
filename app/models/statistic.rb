class Statistic < ActiveRecord::Base
  attr_accessible :concept, :content, :editing, :shots, :user_id, :video_id

  belongs_to :user
  belongs_to :video
end
