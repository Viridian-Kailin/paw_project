class ScheduleController < ApplicationController
  def create
    attr_writer :event, :title_id, :start, :end, :assigned, :location
  end

  def update
    attr_accessor :start, :end, :assigned, :location
  end

  def view
    attr_reader :title_id, :start, :assigned, :location
  end
end
