# frozen_string_literal: true

class GameLog < ApplicationRecord
  validates :inventory_id, presence: true
  serialize :entry, JSON
end
