# frozen_string_literal: true

require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # Validation test
  test "participant must have name and badge" do
    participant = Participant.new()
    assert participant.invalid?

    # Badge missing, proxy true
    assert participants(:missing_badge_proxy).invalid?
    assert participants(:missing_badge_proxy).errors[:badge].any?

    # Badge missing, proxy false
    assert participants(:missing_badge_noproxy).invalid?
    assert participants(:missing_badge_noproxy).errors[:badge].any?

    # Name missing, proxy true
    assert participants(:missing_name_proxy).invalid?
    assert participants(:missing_name_proxy).errors[:name].any?

    # Name missing, proxy false
    assert participants(:missing_name_noproxy).invalid?
    assert participants(:missing_name_noproxy).errors[:name].any?

    # Valid member, proxy true
    assert participants(:greg_proxy).valid?

    # Valid member, proxy false
    assert participants(:beth_noproxy).valid?
  end
end
