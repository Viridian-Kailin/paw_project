class Inventory < ApplicationRecord
  has_many :game_logs
  has_many :libraries
  has_many :schedules

  def game_selection
    "#{title}"
  end

end
