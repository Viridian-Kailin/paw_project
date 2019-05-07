class Library < ApplicationRecord
  validates :inventory_id, presence: true
  validates :participant_id, presence: true
end
