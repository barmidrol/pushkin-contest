class UsersController < ApplicationController

  NUM_USERS = 10.freeze


  def index
    @user = User.new
    render 'registration'
  end

  def registration
    @user = User.new(user_params)

    redirect_to rating_path and return if @user.registration
  end

  def test_bot
    render text: ANSWER
  end


  def rating
    @users = User.rating.limit(NUM_USERS)
  end

  private

  def user_params
    params.require(:user).permit(:username, :url)
  end

end
