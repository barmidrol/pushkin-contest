class User < ActiveRecord::Base

  QUESTION = 'Буря мглою небо кроет, Вихри %WORD% крутя'.freeze
  ANSWER = 'снежные'.freeze
  RESPONSE_IDLE_TIME = 10.seconds.freeze

  before_validation :set_defaults, :correct_url, on: :create
  after_validation :success_registration, on: :create, if: -> { self.errors.empty? }

  # TODO: store level of user and validate

  validates :username, uniqueness: true, presence: true
  validates :token, uniqueness: true
  validates :level, presence: true, numericality: true
  validate :valid_heroku_url

  scope :rating, -> { order('rating desc') }

  def set_defaults
    self.token = SecureRandom.hex
    self.level ||= 1
  end

  def correct_url
    if self.url
      self.url.strip!
      self.url.gsub!(/\/*$/, '')
    end
  end

  def quiz_url
    self.url + '/quiz.json'
  end

  def success_registration
    uri = URI("#{self.url}/registration")

    request = Net::HTTP::Post.new(uri)
    request.set_form_data(question: QUESTION, token: self.token)

    response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: RESPONSE_IDLE_TIME) do |http|
      http.request(request)
    end

    unless response.body.force_encoding("UTF-8").downcase == ANSWER
      self.errors.add(:base, 'Answer is false!')
    end

  rescue Net::ReadTimeout
    self.errors.add(:base, 'Time is over')

  rescue Exception => e
    self.errors.add(:base, e.message)
  end

  def valid_heroku_url
    self.errors.add(:base, 'Not valid url') unless self.url && /^(https?:\/\/[\S]+)(\.herokuapp\.com\/?)$/ =~  self.url
  end

end