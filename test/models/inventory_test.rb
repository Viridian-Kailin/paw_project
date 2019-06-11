# frozen_string_literal: true

require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  # Validation (name, event_id)
  test "inventory must have a title" do
    inventory = Inventory.new(company: "Company",
                            quantity_total: 1)
    # No title
    assert inventory.invalid?

    # Name and event_id provided
    inventory.title = "Title"
    assert inventory.valid?
  end
end
