class WelcomeController < ApplicationController
  def index
    @creaters = Creater.limit(8)
    @photos = Work.photo.includes(:user).limit(8)
  end
end