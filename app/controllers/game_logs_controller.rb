class GameLogsController < ApplicationController
  def new
    @logs = GameLog.new()
  end

  def create
    binding.pry
    @logs = GameLog.new(log_params)

    if @logs.save
      redirect_to "/game_logs"
    else
      render :show
    end
  end

  def log_params
    # Place all key::values into a single, mass array
  end

end