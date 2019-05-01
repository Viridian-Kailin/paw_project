class GameLog < ApplicationRecord
  validates :title, presence: true
  serialize :entry, JSON
end
