class GameLogsController < ApplicationController
  def new
    @logs = GameLog.new()
  end

  def create
    @logs_timestamp = DateTime.new(params[:entry]["timestamp(1i)"].to_i,params[:entry]["timestamp(2i)"].to_i,params[:entry]["timestamp(3i)"].to_i,params[:entry]["timestamp(4i)"].to_i,params[:entry]["timestamp(5i)"].to_i)

    12.times do |i|
      i = i + 1
      if params[:entry]["badge_#{i}".to_sym].blank? == false
        @log = GameLog.create(
          title: params[:entry][:title],
          timestamp: @logs_timestamp,
          badge: params[:entry]["badge_#{i}".to_sym].to_i,
          rating: params[:entry]["rating_#{i}".to_sym].to_i
          )
      end
    end

    if @log.save
      redirect_to "/game_logs"
      flash[:notice] = "An entry for #{params[:entry][:title]} at #{@logs_timestamp} has been added."
    else
      render :show
    end
  end

  def initial_params

    # Place all key::values into a single, mass array
    params.require(:entry).permit(:title).merge(timestamp: @logs_timestamp)

  end

end