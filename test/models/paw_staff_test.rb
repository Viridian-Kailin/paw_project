# frozen_string_literal: true

require 'test_helper'

class PawStaffTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "paw staff must have a name" do
    pawstaff = PawStaff.new(role: "Role",
                            title: "Organizer",
                            phone: "555-555-5555",
                            badge: 1000,
                            email: "test@test.test")
    # No name
    assert pawstaff.invalid?

    # Name provided
    pawstaff.name = "Greg"
    assert pawstaff.valid?
  end
end
