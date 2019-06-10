# frozen_string_literal: true

class ConStaff < ApplicationRecord
  validates :name, presence: true
  validates :event_id, presence: true
end
