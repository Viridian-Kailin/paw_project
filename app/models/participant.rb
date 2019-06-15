# frozen_string_literal: true

#:nodoc:
class Participant < ApplicationRecord
  validates :badge, presence: true, uniqueness: true
  validates :name, presence: true

  def badge_selection
    badge.to_s
  end
end
