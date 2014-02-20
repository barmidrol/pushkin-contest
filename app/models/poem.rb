class Poem < ActiveRecord::Base
  scope :random_poem, -> { order('random()').limit(1).first }
end
