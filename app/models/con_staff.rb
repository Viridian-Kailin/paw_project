# frozen_string_literal: true
#:nodoc:
class ConStaff < ApplicationRecord
  validates :name, presence: true
  validates :event_id, presence: true
end
