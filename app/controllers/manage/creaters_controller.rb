class Manage::CreatersController < Manage::ApplicationController
  before_action :set_creater, only: %i[show update]

  def index
    @creaters = Creater.all
    @identifying_creaters = Creater.identifying
  end

  def show
  end

  def update
    if @creater.update(creater_params)
      redirect_to manage_creater_path(@creater), notice: '更新しました'
    else
      flash.now[:alert] = @creater.errors.full_messages.join("\n")
      render :show
    end
  end

  private

  def set_creater
    @creater = Creater.find params[:id]
  end

  def creater_params
    params.require(:creater).permit(
      :identification
    )
  end
end