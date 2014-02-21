class User < ActiveRecord::Base

  QUESTION = 'Буря мглою небо кроет, Вихри %WORD% крутя'.freeze
  ANSWER = 'снежные'.freeze
  RESPONSE_IDLE_TIME = 10.seconds.freeze

  before_validation :generate_token, on: :create

  # TODO: add url validation for herokuapp domain
  # http://my.herokuapp.com

  validates :username, uniqueness: true, present: true
  validates :url, presence: true, url: true
  validates :token, uniqueness: true
  validate :success_registration

  scope :rating, -> { order('rating desc') }

  def generate_token
    self.token = SecureRandom.hex
  end

  def success_registration
    uri = URI(self.url)
    # TODO: /registration

    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(question: QUESTION, token: self.token)

    response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: RESPONSE_IDLE_TIME) do |http|
      http.request(request)
    end

    unless response.body.downcase == ANSWER #response.body.include?(ANSWER)
      self.errors.add(:base, 'Answer is false!')
    end

  rescue Net::ReadTimeout
    self.errors.add(:base, 'Time is over')
    false

  rescue Exception => e
    self.errors.add(:base, e.message)
    false
  end

end
