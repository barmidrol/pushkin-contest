class UsersController < ApplicationController

  QUESTION = 'Буря мглою небо кроет, Вихри %word% крутя'.freeze
  ANSWER = 'снежные'.freeze
  RESPONSE_TIME = 10.freeze
  NUM_USERS = 10.freeze


  def index
    @user = User.new
    render 'registration'
  end

  def registration
    @user = User.new(user_params)

    if @user.valid?
      @user.generate_token
      uri = URI(@user.url)
      request = Net::HTTP::Post.new(uri.path)
      request.set_form_data('question' => QUESTION)

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.read_timeout = RESPONSE_TIME #sec
        http.request(request)
      end

      @user.errors.add(:base, 'ANSWER IS FALSE!') if response.body.downcase != ANSWER  #response.body.include?(ANSWER)

      @user.save if @user.errors.empty?
    end


  rescue Timeout::Error => e
    @user.errors.add(:base, 'TIME OUT!')
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
