# frozen_string_literal: true

#:nodoc:
class GameLog < ApplicationRecord
  validates :inventory_id, presence: true
  validates :timestamp, presence: true
  validates :event_id, presence: true
  serialize :entry, JSON

  def self.log_info(logs)
    @log_info = []
    logs.length.times do |i|
      @log_info[i] = {
        id: logs[i][:id],
        inventory_id: logs[i][:inventory_id],
        title: Inventory.find(logs[i][:inventory_id])[:title],
        timestamp: logs[i][:timestamp],
        participant_id: logs[i][:participant_id],
        member: Participant.find(logs[i][:participant_id])[:name],
        rating: logs[i][:rating]
      }
    end
    @log_info
  end
end
