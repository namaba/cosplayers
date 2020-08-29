class UsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
    current_user.attributes = user_params

    if current_user.save
      redirect_to current_user
    else
      flash.now[:alert] = current_user.errors.full_messages.join("\n")
      render :new
    end
  end

  def download
    data = current_user.avatar.download
    send_data(data, type: 'image/png', filename: 'download.jpg')
  end

  private

  def user_params
    params.required(:user).permit(
      :username,
      :introduction,
      :avatar
    )
  end
end