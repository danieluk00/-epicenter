class UsersController < ApplicationController
  def new
  end

  def index
    @users = User.geocoded
    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
  end
end
