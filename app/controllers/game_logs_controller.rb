class GameLogsController < ApplicationController
  skip_before_action :admin, only: [:update, :delete, :index]

  def new
    @logs = GameLog.new()
  end

  def create

    @logs_timestamp = DateTime.new(params[:entry]["timestamp(1i)"].to_i,params[:entry]["timestamp(2i)"].to_i,params[:entry]["timestamp(3i)"].to_i,params[:entry]["timestamp(4i)"].to_i,params[:entry]["timestamp(5i)"].to_i)

    12.times do |i|
      i = i + 1
      if params[:entry]["badge_#{i}".to_sym].blank? == false && Participant.all.where(badge: params[:entry]["badge_#{i}".to_sym].to_i) != []

        @log = GameLog.create(
          inventory_id: params[:entry][:inventory_id],
          timestamp: @logs_timestamp,
          participant_id: Participant.where(badge: params[:entry]["badge_#{i}"]).ids[0],
          rating: params[:entry]["rating_#{i}".to_sym].to_i
          )
      end
    end

    if @log.save
      redirect_to "/game_logs"
      flash[:notice] = "Entry for #{Inventory.where(id: params[:entry][:inventory_id]).pluck(:title)[0]} at #{@logs_timestamp} has been added."
    else
      render :show
    end
  end

  def need_reg
    @members = Participant.all
    @example = params[:participants]

    if @members.where(badge: @example) == []
      render json: { :badge_info => @example }, status: 406
    else
      render json: { :members => @members.where(badge: @example) }, status: 304
    end

  end

  def initial_params

    # Place all key::values into a single, mass array
    params.require(:entry).permit(:inventory_id).merge(timestamp: @logs_timestamp)

  end

end