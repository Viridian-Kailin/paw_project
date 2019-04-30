class Participant < ApplicationRecord
  validates :badge, presence: true, uniqueness: true
  validates :name, presence: true
end
