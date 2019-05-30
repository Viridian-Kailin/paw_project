class ScheduleController < ApplicationController
  skip_before_action :admin, only: [:index]

  def new
    @schedule = Schedule.new
  end
end
