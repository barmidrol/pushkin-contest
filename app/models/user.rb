class User < ActiveRecord::Base

  validate :username, uniqueness: true, present: true
  validate :url, present: true

  scope :rating, -> { order('rating desc') }

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end

end