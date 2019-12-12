class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.token = SecureRandom.hex(10)
    @event = Event.find_by(event_token: params[:event_token])
    @user.event = @event
    if @user.save
      redirect_to waiting_path + "?event=#{@event.event_token}&user=#{@user.token}"
    else
      render :new
    end
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
  
  private

  def user_params
    params.require(:user).permit(:name, :address, :email)
  end

end
