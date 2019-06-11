# frozen_string_literal: true

require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # Validation test
  test "participant must have name and badge" do
    participant = Participant.new(phone: "555-555-5555",
                                  email: "test@test.test",
                                  pref: "Text",
                                  proxy: false
                                  )
    # No name or badge
    assert participant.invalid?

    # Name only
    participant.name = "Greg"
    assert participant.invalid?
    assert participant.errors[:badge].any?
    assert_equal ["can't be blank"], participant.errors[:badge]

    # Badge only
    participant.name = nil
    participant.badge = 1000
    assert participant.invalid?
    assert participant.errors[:name].any?
    assert_equal ["can't be blank"], participant.errors[:name]

    # Name and badge provided
    participant.name = "Greg"
    assert participant.valid?
  end
end
