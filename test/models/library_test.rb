# frozen_string_literal: true

require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test 'library must have a inventory_id and participant_id' do
    library = Library.new
    assert library.invalid?

    # No inventory_id
    assert libraries(:missing_title).invalid?
    assert libraries(:missing_title).errors[:inventory_id].any?
    assert_equal ["can't be blank"], libraries(:missing_title).errors[:inventory_id]

    # No participant_id
    assert libraries(:missing_member).invalid?
    assert libraries(:missing_member).errors[:participant_id].any?
    assert_equal ["can't be blank"], libraries(:missing_member).errors[:participant_id]

    # Name and event_id provided
    assert libraries(:first_checkin).valid?
  end
end
