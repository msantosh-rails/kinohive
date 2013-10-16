module ApplicationHelper

  def alert_class(type)
    {error: "alert-error", notice: "alert-success", alert: "alert-info"}[type]
  end

  def user_awarded_hivecoins?(user,video)
		return AwardingHivecoin.find_by_user_id_and_video_id(user,video)
  end
  
  def own_videos?(user,video)
  	return Video.find_by_user_id_and_id(user,video)
  end

  def admin_own_videos?(video)
  	return Video.find_by_user_id_and_id(nil,video)
  end

  def action_active(action_name)
    "active" if controller.action_name == action_name
  end
end
