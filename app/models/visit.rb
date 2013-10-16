class Visit < ActiveRecord::Base
  attr_accessible :ip_address, :location, :page, :user_id

	belongs_to :user
end
