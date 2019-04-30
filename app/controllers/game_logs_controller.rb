class GameLogsController < ApplicationController
  def new
    @logs = GameLog.new()
  end

  def create
    @logs = GameLog.new(initial_params)

    if @logs.save
      redirect_to "/game_logs"
    else
      render :show
    end
  end

  def initial_params
    @logs_timestamp = DateTime.new(params[:entry]["timestamp(1i)"].to_i,params[:entry]["timestamp(2i)"].to_i,params[:entry]["timestamp(3i)"].to_i,params[:entry]["timestamp(4i)"].to_i,params[:entry]["timestamp(5i)"].to_i)

    @badgerating_array = Array.new

    for i in 1..12
      if params[:entry]["badge_#{i}"].blank? == false
        add_badge = params[:entry]["badge_#{i}"].to_i

        @badgerating_array.push params[:entry]["badge_#{i}"].to_i
        @badgerating_array.push params[:entry]["rating_#{i}"].to_i
      end
    end

    # Place all key::values into a single, mass array
    params.require(:entry).permit(:title).merge(timestamp: @logs_timestamp)

  end

end