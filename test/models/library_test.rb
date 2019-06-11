# frozen_string_literal: true

require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "library must have a inventory_id and participant_id" do
    library = Library.new(checked_in: Time.new(2019,06,15,10,30,00),
                          quantity_left: 1,
                          event_id: 1
                          )
    # No inventory_id or participant_id
    assert library.invalid?

    # No inventory_id
    library.participant_id = 1
    assert library.invalid?
    assert library.errors[:inventory_id].any?
    assert_equal ["can't be blank"], library.errors[:inventory_id]

    # No participant_id
    library.participant_id = nil
    library.inventory_id = 1
    assert library.invalid?
    assert library.errors[:participant_id].any?
    assert_equal ["can't be blank"], library.errors[:participant_id]

    # Name and event_id provided
    library.participant_id = 1
    assert library.valid?
  end
end
