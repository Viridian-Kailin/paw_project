# frozen_string_literal: true

require 'test_helper'

class PawStaffTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test 'paw staff must have a name' do
    pawstaff = PawStaff.new
    assert pawstaff.invalid?

    # No name
    assert paw_staffs(:missing_name).invalid?
    assert paw_staffs(:missing_name).errors.any?

    # Name provided
    assert paw_staffs(:grace).valid?
  end
end
