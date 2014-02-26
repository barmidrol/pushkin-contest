class Poem < ActiveRecord::Base
  scope :random, -> { order('random()') }
end
