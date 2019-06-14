# frozen_string_literal: true

require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test 'inventory must have a title' do
    inventory = Inventory.new
    assert inventory.invalid?

    # No title
    assert inventories(:missing_title).invalid?
    assert inventories(:missing_title).errors[:title].any?
    assert_equal ["can't be blank"], inventories(:missing_title).errors[:title]

    # Name and event_id provided
    assert inventories(:pikoko).valid?
  end
end
