class GameLibraryController < ApplicationController
  def checkout
    attr_writer :title, :event, :badge_log, :checked_out
  end

  def checkin
    attr_writer :title, :event, :badge_log, :checked_in
  end

  def viewlogs
    attr_reader :title, :badge_log, :checked_out, :checked_in, :quantity_left
  end

  def memberinfo
    #Load from participants table
    attr_reader
  end

  def gameschedule
    #Load from schedule table
    attr_reader
  end
end
