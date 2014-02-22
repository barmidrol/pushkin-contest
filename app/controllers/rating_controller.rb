class RatingController < ApplicationController

  NUM_USERS = 10.freeze

  def index
    @users = User.rating.limit(NUM_USERS)
  end

end
