module ApplicationHelper
  def current_user_is?(target_creater)
    current_user&.creater == target_creater
  end
end
