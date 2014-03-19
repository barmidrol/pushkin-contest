class User < ActiveRecord::Base
  before_validation :set_token, on: :create
  before_save :set_level

  validates :username, :token, uniqueness: true
  validates :url, :username, :level, presence: true
  validates :level, numericality: true
  validates :url, format: { with: URI::regexp, message: 'Not valid URL' }
  validates :url, format: { with: /\A.*\.herokuapp\.com\z/,
                            message: 'Invalid url. Only herokuapp domains are allowed. Example domain:  http://pushckinrocks.herokuapp.com' }

  validates_with ConfirmRegistrationValidator, on: :create

  scope :rating, -> { order('rating desc') }

  def set_token
    self.token = SecureRandom.hex
  end

  def set_level
    self.level = case (self.rating || 0)
                 when 0..10   then 1
                 when 11..20 then 2
                 when 21..30 then 3
                 when 31..40 then 4
                 when 41..Float::INFINITY then 5
                 end
  end

end
