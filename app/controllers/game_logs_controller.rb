class GameLogsController < ApplicationController
  skip_before_action :admin, only: [:index, :show, :create, :need_reg]

  def new
    @logs = GameLog.new()
  end

  def show
    @logs = GameLog.all.order(:inventory_id)
    @log_info = Array.new

    @logs.length.times { |i|
      @log_info[i] = { id: @logs[i][:id], inventory_id: @logs[i][:inventory_id], title: Inventory.where(id: @logs[i][:inventory_id])[0][:title], timestamp: @logs[i][:timestamp], participant_id: @logs[i][:participant_id], member: Participant.where(id: @logs[i][:participant_id])[0][:name], rating: @logs[i][:rating] }
    }
  end

  def edit
    @log = GameLog.find(params[:id])
    @log_info = {
      id: @log[:id],
      inventory_id: @log[:inventory_id],
      title: Inventory.where(id: @log[:inventory_id])[0][:title],
      timestamp: @log[:timestamp],
      participant_id: @log[:participant_id],
      member: Participant.where(id: @log[:participant_id])[0][:name],
      rating: @log[:rating]
    }
    render 'game_logs/edit', layout: false
  end

  def update
    @log = GameLog.find(params[:id])
    if @log.update_attributes(update_params)
      flash[:notice] = "GameLog updated."
      redirect_to game_logs_total_url
    else
      flash[:alert] = "Unable to save edit."
      render 'edit'
    end
  end

  def destroy
    GameLog.find(params[:id]).destroy
    flash[:notice] = "Single game log entry has been deleted."
    redirect_to game_logs_total_url
  end

  def create
    @logs_timestamp = DateTime.new(params["timestamp(1i)"].to_i,params["timestamp(2i)"].to_i,params["timestamp(3i)"].to_i,params["timestamp(4i)"].to_i,params["timestamp(5i)"].to_i)

    12.times do |i|
      if params["badge_#{i}".to_sym].blank? == false && Participant.all.where(badge: params["badge_#{i}".to_sym].to_i) != []

        @log = GameLog.create({
          inventory_id: params[:inventory_id],
          timestamp: @logs_timestamp,
          participant_id: Participant.where(badge: params["badge_#{i}"]).ids[0],
          rating: params["rating_#{i}".to_sym].to_i,
          event_id: params[:event_id]
          })
      end
    end

    if @log.save!
      redirect_to "/game_logs"
      flash[:notice] = "Entry for #{Inventory.where(id: params[:inventory_id]).pluck(:title)[0]} at #{@logs_timestamp} has been added."
    else
      render :show
    end
  end

  def need_reg
    @member = Participant.find_by(badge: params[:badge_id])

    if @member == nil
      head 406
    else
      head 304
    end
  end

  private

  def initial_params
    accepted_params = Hash.new
    accepted_params[:inventory_id] = params[:inventory_id]
    accepted_params[:event_id] = params[:event_id]
    12.times { |p|
      if params["badge_#{p}"] != ""
        if params["rating_#{p}"] != ""
          accepted_params["badge_#{p}"] = params["badge_#{p}"]
          accepted_params["rating_#{p}"] = params["rating_#{p}"]
        else
          accepted_params["badge_#{p}"] = params["badge_#{p}"]
          accepted_params["rating_#{p}"] = 1
        end
      end
    }

    params.require(accepted_params)
  end

  def update_params
    params.require(:game_log).permit(:rating)
  end

end