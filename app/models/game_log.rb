# frozen_string_literal: true
#:nodoc:
class GameLog < ApplicationRecord
  validates :inventory_id, presence: true
  validates :timestamp, presence: true
  validates :event_id, presence: true
  serialize :entry, JSON
end
