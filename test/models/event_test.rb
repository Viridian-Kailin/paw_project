# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "event must have an event_code" do
    event = Event.new(event_year: 2019,
                      event_location: "Red Lion",
                      set: false
                      )
    # No event_code
    assert event.invalid?

    # Event_code provided
    event.event_code = "GS2019"
    assert event.valid?
  end
end
