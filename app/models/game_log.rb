class GameLog < ApplicationRecord
  has_many :badge
  has_many :title
end
