# frozen_string_literal: true

require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "schedule must have an inventory_id, start, end, and event_id" do
    schedule = Schedule.new()
    assert schedule.invalid?

    # No inventory_id
    assert schedules(:missing_title).invalid?
    assert schedules(:missing_title).errors[:inventory_id].any?
    assert_equal ["can't be blank"], schedules(:missing_title).errors[:inventory_id]

    # No event_id
    assert schedules(:missing_event).invalid?
    assert schedules(:missing_event).errors[:event_id].any?
    assert_equal ["can't be blank"], schedules(:missing_event).errors[:event_id]

    # No start
    assert schedules(:missing_start).invalid?
    assert schedules(:missing_start).errors[:start].any?
    assert_equal ["can't be blank"], schedules(:missing_start).errors[:start]

    # No end
    assert schedules(:missing_end).invalid?
    assert schedules(:missing_end).errors[:end].any?
    assert_equal ["can't be blank"], schedules(:missing_end).errors[:end]

    # Inventory_id, start, end and event_id provided
    assert schedules(:first_game).valid?
  end
end