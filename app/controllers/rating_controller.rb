class RatingController < ApplicationController

  def index
    @users = User.rating.limit(NUM_USERS)
  end

end
