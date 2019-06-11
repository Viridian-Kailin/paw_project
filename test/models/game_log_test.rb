# frozen_string_literal: true

require 'test_helper'

class GameLogTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "game log must have an inventory_id, timestamp, and event_id" do
    gamelog = GameLog.new()
    assert gamelog.invalid?

    # No inventory_id
    assert game_logs(:missing_title).invalid?
    assert game_logs(:missing_title).errors[:inventory_id].any?
    assert_equal ["can't be blank"], game_logs(:missing_title).errors[:inventory_id]

    # No timestamp
    assert game_logs(:missing_timestamp).invalid?
    assert game_logs(:missing_timestamp).errors[:timestamp].any?
    assert_equal ["can't be blank"], game_logs(:missing_timestamp).errors[:timestamp]

    # No event_id
    assert game_logs(:missing_event).invalid?
    assert game_logs(:missing_event).errors[:event_id].any?
    assert_equal ["can't be blank"], game_logs(:missing_event).errors[:event_id]

    # Inventory_id, timestamp, and event_id provided
    assert game_logs(:first_log).valid?
  end
end
