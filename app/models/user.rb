class User < ActiveRecord::Base
  before_validation :set_token, on: :create
  before_validation :set_level

  validates :username, :token, uniqueness: true
  validates :url, :username, :level, presence: true
  validates :level, numericality: true
  validates :url, format: { with: URI::regexp, message: 'Not valid URL' }
  # validates :url, format: { with: /\A.*\.herokuapp\.com\z/,
  #                           message: 'Invalid url. Only herokuapp domains are allowed. Example domain:  http://pushckinrocks.herokuapp.com' }

  validates_with ConfirmRegistrationValidator, on: :create

  scope :rating, -> { order('rating desc') }

  def set_token
    self.token = SecureRandom.hex
  end

  def set_level
    self.level = case (self.rating || 0)
                 when 0..100   then 1
                 when 101..200 then 2
                 when 201..300 then 3
                 when 301..400 then 4
                 when 401..Float::INFINITY then 5
                 end
  end

end
