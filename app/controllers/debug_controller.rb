class DebugController < ApplicationController
  
  def reset
    @token = params[:token]
    @level = params[:level] ? params[:level].to_i : 1
    
    @user = User.find_by_token(@token)

    if !@user
      render json: { error: "User with this token doesn't exist" }
    elsif !@level.between? 1, 8
      render json: { error: "Level should be in range [1..8]" }
    else
      @user.update_attributes(rating: (@level - 1) * 100)
      render json: { message: "Level successfully updated" }
    end
  end
end
