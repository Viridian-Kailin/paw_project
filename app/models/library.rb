# frozen_string_literal: true

#:nodoc:
class Library < ApplicationRecord
  # Update table so that there is a static one-to-one relationship between inventory quantity and initial quantity in the library?

  validates :inventory_id, presence: true
  validates :participant_id, presence: true

  def self.games_out
    @history = {}
    @library = Library.all.order(checked_out: :desc)
    t = 0
    @library.each do |log|
      next unless log.checked_out

      @history[t] = { time: log.checked_out,
                      quantity: log.quantity_left,
                      name: Participant.find(log.participant_id).name,
                      badge: Participant.find(log.participant_id).badge,
                      game: Inventory.find(log.inventory_id).title }
      t += 1
    end
    @history
  end
end
