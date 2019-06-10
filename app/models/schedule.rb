# frozen_string_literal: true

class Schedule < ApplicationRecord
  validates :inventory_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :event_id, presence: true
end
