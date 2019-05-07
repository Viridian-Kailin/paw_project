class ScheduleController < ApplicationController
  def new
    @schedule = Schedule.new
  end
end
