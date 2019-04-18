class Participant < ApplicationRecord
  validates :badge, presence: true
end
