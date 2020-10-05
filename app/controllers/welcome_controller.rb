class WelcomeController < ApplicationController
  def index
    @creaters = Creater.limit(12)
    @photos = Work.photo.includes(:user).limit(12)
  end
end