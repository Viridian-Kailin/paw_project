# frozen_string_literal: true

require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "schedule must have an inventory_id, start, end, and event_id" do
    schedule = Schedule.new(paw_staff_id: 1,
                            location: "Q01")
    # No inventory_id, start, end or event_id
    assert schedule.invalid?

    # No inventory_id
    schedule.event_id = 1
    schedule.start = Time.new(2019,06,15,10)
    schedule.end = Time.new(2019,06,15,10,30)
    assert schedule.invalid?
    assert schedule.errors[:inventory_id].any?
    assert_equal ["can't be blank"], schedule.errors[:inventory_id]

    # No event_id
    schedule.event_id = nil
    inventory_id = 1
    assert schedule.invalid?
    assert schedule.errors[:event_id].any?
    assert_equal ["can't be blank"], schedule.errors[:event_id]

    # No start
    schedule.event_id = 1
    schedule.start = nil
    assert schedule.invalid?
    assert schedule.errors[:start].any?
    assert_equal ["can't be blank"], schedule.errors[:start]

    # No end
    schedule.start = Time.new(2019,06,15,10)
    schedule.end = nil
    assert schedule.invalid?
    assert schedule.errors[:end].any?
    assert_equal ["can't be blank"], schedule.errors[:end]

    # Inventory_id, start, end and event_id provided
    schedule.event_id = 1
    schedule.start = Time.new(2019,06,15,10)
    schedule.end = Time.new(2019,06,15,10,30)
    schedule.inventory_id = 1
    assert schedule.valid?
  end
end