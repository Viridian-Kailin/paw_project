# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "event must have an event_code" do
    event = Event.new()
    assert event.invalid?

    # Missing event_code
    assert events(:missing_code).invalid?
    assert events(:missing_code).errors[:event_code].any?
    assert_equal ["can't be blank"], events(:missing_code).errors[:event_code]

    # Event_code provided
    assert events(:gamestorm).valid?
  end
end
