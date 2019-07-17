# frozen_string_literal: true

#:nodoc:
class PawStaff < ApplicationRecord
  validates :name, presence: true

  def staff_name
    "#{name} -- Badge: #{badge}"
  end

  def self.simplify(staff)
    all_info = PawStaff.find(staff)
    simple_info = { ID: all_info[:id],
                    Badge: all_info[:badge],
                    Name: all_info[:name],
                    Title: all_info[:title],
                    Phone: all_info[:phone],
                    Email: all_info[:email],
                    Role: all_info[:role] }
  end
end
