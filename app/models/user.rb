class User < ActiveRecord::Base

  QUESTION = 'Буря мглою небо кроет, Вихри %word% крутя'.freeze
  ANSWER = 'снежные'.freeze
  RESPONSE_IDLE_TIME = 10.seconds.freeze

  validate :username, uniqueness: true, present: true
  validates :url, presence: true, url: true
  validate :token, uniqueness: true

  scope :rating, -> { order('rating desc') }

  def generate_token
    self.token = SecureRandom.urlsafe_base64(nil, false)
  end

  def registration
    uri = URI(self.url)
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data('question' => QUESTION)

    response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: RESPONSE_IDLE_TIME) do |http|
      http.request(request)
    end

    if response.body.downcase == ANSWER #response.body.include?(ANSWER)
      self.generate_token
      self.save
    else
      self.errors.add(:base, 'Answer is false!')
    end

    self.errors.empty?


  rescue Net::ReadTimeout
    self.errors.add(:base, 'Time is over')
    false

  rescue Exception => e
    self.errors.add(:base, e.message)
    false
  end

end

