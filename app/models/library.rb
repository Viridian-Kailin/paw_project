class Library < ApplicationRecord
  has_many :title
  has_many :badge
  has_many :event_code
end
