class GameLogsController < ApplicationController
  def new
    attr_writer :title, :timestamp, :badge_log, :rating
  end

  def view
    attr_reader :id, :title, :timestamp, :badge_log, :rating
  end

  def update
    attr_reader :id, :badge_log
    attr_accessor :rating
  end
end
