class GameLogsController < ApplicationController
  def new
    @logs = GameLog.new()
  end

  def create
    @logs_timestamp = DateTime.new(params[:entry]["timestamp(1i)"].to_i,params[:entry]["timestamp(2i)"].to_i,params[:entry]["timestamp(3i)"].to_i,params[:entry]["timestamp(4i)"].to_i,params[:entry]["timestamp(5i)"].to_i)


    @log_hash = Hash.new

    i = 0

    for i in 1..12

      if params[:entry]["badge_#{i}"].blank? == false
        initial_hash = Hash.new

        initial_hash.store :title, params[:entry][:title]
        initial_hash.store :timestamp, @logs_timestamp
        initial_hash.store :badge, params[:entry]["badge_#{i}"].to_i
        initial_hash.store :rating, params[:entry]["rating_#{i}"].to_i

        @log_hash.merge!(initial_hash)
      end
      i = i + 1
    end

    binding.pry

    @logs = GameLog.new(@log_hash)

    if @logs.save
      redirect_to "/game_logs"
    else
      render :show
    end
  end

  def initial_params

    # Place all key::values into a single, mass array
    params.require(:entry).permit(:title).merge(timestamp: @logs_timestamp)

  end

end