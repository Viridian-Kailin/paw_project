# frozen_string_literal: true

#:nodoc:
class ConStaff < ApplicationRecord
  validates :name, presence: true
  validates :event_id, presence: true

  def self.con_list
    @con_staffs = ConStaff.all
    @con_info = []

    @con_staffs.length.times do |i|
      @con_info[i] = {
        id: @con_staffs[i][:id],
        name: @con_staffs[i][:name],
        title: @con_staffs[i][:title],
        phone: @con_staffs[i][:phone],
        email: @con_staffs[i][:email],
        event_id: @con_staffs[i][:event_id],
        event_code: Event.find(@con_staffs[i][:event_id])[:event_code]
      }
    end
    @con_info
  end
end
