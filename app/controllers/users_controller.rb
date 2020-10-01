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

  def creditcard
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    customer = Payjp::Customer.create(
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
    )
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