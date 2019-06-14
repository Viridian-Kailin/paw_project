# frozen_string_literal: true
#:nodoc:
class Library < ApplicationRecord
  validates :inventory_id, presence: true
  validates :participant_id, presence: true

  # Update table so that there is a static one-to-one relationship between inventory quantity and initial quantity in the library?
end
