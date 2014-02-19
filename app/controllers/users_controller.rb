class UsersController < ApplicationController

  QUESTION = 'Буря мглою небо кроет, Вихри %word% крутя'.freeze
  ANSWER = 'снежные'.freeze
  RESPONSE_IDLE_TIME = 10.seconds.freeze
  NUM_USERS = 10.freeze


  def index
    @user = User.new
    render 'registration'
  end

  def registration
    @user = User.new(user_params)

    if @user.valid?
      #@user.generate_token
      uri = URI(@user.url)
      request = Net::HTTP::Post.new(uri.path)
      request.set_form_data('question' => QUESTION)

      response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: RESPONSE_IDLE_TIME) do |http|
        http.request(request)
      end

      @user.errors.add(:base, 'Answer is false!')  if response.body.downcase != ANSWER #response.body.include?(ANSWER)

      @user.save if @user.errors.empty?
    end

  rescue Timeout::Error => e
    @user.errors.add(:base, 'Time is over!')

  rescue Exception => e
    @user.errors.add(:base, e.message)
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
