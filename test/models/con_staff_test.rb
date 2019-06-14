# frozen_string_literal: true

require 'test_helper'

class ConStaffTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test 'con staff must have a name and event_id' do
    constaff = ConStaff.new
    assert constaff.invalid?

    # No name
    assert con_staffs(:missing_name).invalid?
    assert con_staffs(:missing_name).errors[:name].any?
    assert_equal ["can't be blank"], con_staffs(:missing_name).errors[:name]

    # No event_id
    assert con_staffs(:missing_event).invalid?
    assert con_staffs(:missing_event).errors[:event_id].any?
    assert_equal ["can't be blank"], con_staffs(:missing_event).errors[:event_id]

    # Name and event_id provided
    con_staffs(:greg)
    assert con_staffs(:greg).valid?
  end
end
