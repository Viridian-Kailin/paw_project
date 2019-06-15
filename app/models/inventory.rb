# frozen_string_literal: true

#:nodoc:
class Inventory < ApplicationRecord
  has_many :game_logs
  has_many :libraries
  has_many :schedules

  validates :title, presence: true

  def game_selection
    title.to_s
  end
end
