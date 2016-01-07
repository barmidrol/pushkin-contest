class DebugController < ApplicationController
  
  def reset
    @token = params[:token]
    @level = params[:level] ? params[:level].to_i : 1
    
    @user = User.find_by_token(@token)
    message = ''
    if !@user
      message = "User with this token doesn't exist"
    elsif !@level.between? 1, 8
      message = "Level should be in range [1..8]"
    else
      @user.update_attributes(rating: (@level - 1) * 100)
      message = "Level successfully updated" 
    end
    render json: { message: message }
  end
end
