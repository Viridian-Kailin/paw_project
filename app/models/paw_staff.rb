# frozen_string_literal: true

class PawStaff < ApplicationRecord
  validates :name, presence: true

  def staff_name
    "#{name} -- Badge: #{badge}"
  end
end
