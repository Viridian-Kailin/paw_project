# frozen_string_literal: true

require 'test_helper'

class ConStaffTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "con staff must have a name and event_id" do
    constaff = ConStaff.new(title: "Organizer",
                            phone: "555-555-5555",
                            email: "test@test.test")
    # No name or event_id
    assert constaff.invalid?

    # No name
    constaff.event_id = 1
    assert constaff.invalid?
    assert constaff.errors[:name].any?
    assert_equal ["can't be blank"], constaff.errors[:name]

    # No event_id
    constaff.event_id = nil
    constaff.name = "Greg"
    assert constaff.invalid?
    assert constaff.errors[:event_id].any?
    assert_equal ["can't be blank"], constaff.errors[:event_id]

    # Name and event_id provided
    constaff.event_id = 1
    assert constaff.valid?
  end
end
