class Manage::ApplicationController < ApplicationController
  before_action :authenticate_admin_user

  private

  def authenticate_admin_user
    redirect_to root_path, alert: '権限がありません' unless current_user.is_admin?
  end
end