class CreatersController < ApplicationController
  before_action :set_creater, only: %i[show edit update]
  before_action :authenticate_own_user, only: %i[edit update]

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
    @photos = @creater.photos.order(id: :desc).page(params[:page]).per(20)
  end

  def edit
  end

  private

  def set_creater
    @creater = Creater.includes(:user).find params[:id]
  end

  def authenticate_own_user
    redirect_to root_path, alert: '許可されたユーザーではありません' unless @creater == current_user.creater
  end

  def creater_params
    params.required(:creater).permit(
      :description,
      :min_charge,
      :is_accepting
    )
  end
end