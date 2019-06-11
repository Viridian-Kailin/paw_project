# frozen_string_literal: true

require 'test_helper'

class GameLogTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "game log must have an inventory_id, timestamp, and event_id" do
    gamelog = GameLog.new(participant_id: 1,
                          rating: 3)
    # No inventory_id, timestamp, or event_id
    assert gamelog.invalid?

    # No inventory_id
    gamelog.event_id = 1
    gamelog.timestamp = Time.new(2019,04,15,10,20,38)
    assert gamelog.invalid?
    assert gamelog.errors[:inventory_id].any?
    assert_equal ["can't be blank"], gamelog.errors[:inventory_id]

    # No timestamp
    gamelog.timestamp = nil
    gamelog.inventory_id = 1
    assert gamelog.invalid?
    assert gamelog.errors[:timestamp].any?
    assert_equal ["can't be blank"], gamelog.errors[:timestamp]

    # No event_id
    gamelog.event_id = nil
    gamelog.timestamp = Time.new(2019,04,15,10,20,38)
    assert gamelog.invalid?
    assert gamelog.errors[:event_id].any?
    assert_equal ["can't be blank"], gamelog.errors[:event_id]

    # Inventory_id, timestamp, and event_id provided
    gamelog.event_id = 1
    assert gamelog.valid?
  end
end
