class CreatersController < ApplicationController
  before_action :set_creater, only: %i[edit update]

  def index
    @creaters = Creater.page(params[:page]).per(20)
  end

  def new
    @creater = Creater.new
  end

  def create
    @creater = current_user.build_creater(creater_params)

    if @creater.save
      redirect_to current_user, notice: 'コスプレイヤーになりました'
    else
      render :new, alert: '保存できませんでした'
    end
  end

  def show
    @creater = Creater.includes(:user).find params[:id]
  end

  def edit
  end

  private

  def set_creater
    @creater = current_user.creater
  end

  def creater_params
    params.required(:creater).permit(
      :description,
      :min_charge,
      :is_accepting
    )
  end
end