# frozen_string_literal: true

#:nodoc:
class GameLogsController < ApplicationController
  skip_before_action :admin, only: %i[index show create need_reg]

  def new
    @logs = GameLog.new
  end

  def show
    @logs = GameLog.log_info(GameLog.all)
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
      flash[:notice] = 'GameLog updated.'
      redirect_to game_logs_total_url
    else
      flash[:alert] = 'Unable to save edit.'
      render 'edit'
    end
  end

  def destroy
    GameLog.find(params[:id]).destroy
    flash[:notice] = 'Single game log entry has been deleted.'
    redirect_to game_logs_total_url
  end

  def create
    @logs_timestamp = DateTime.new(
      params['timestamp(1i)'].to_i,
      params['timestamp(2i)'].to_i,
      params['timestamp(3i)'].to_i,
      params['timestamp(4i)'].to_i,
      params['timestamp(5i)'].to_i
    )

    12.times do |i|
      next unless params["badge_#{i}".to_sym].blank? == false && Participant.all.where(badge: params["badge_#{i}".to_sym].to_i) != []

      @log = GameLog.new(
        inventory_id: params[:inventory_id],
        timestamp: @logs_timestamp,
        participant_id: Participant.where(badge: params['badge_1']).ids[0],
        rating: params['rating_1'.to_sym].to_i,
        event_id: params[:event_id]
      )
    end

    if @log.save!
      flash[:notice] = "Entry for #{Inventory.where(id: params[:inventory_id]).pluck(:title)[0]} at #{@logs_timestamp} has been added."
    else
      flash[:error] = @log.errors.full_messages
    end

    redirect_to '/game_logs'
  end

  def need_reg
    @member = Participant.find_by(badge: params[:badge_id])

    if @member.nil?
      head 406
    else
      head 304
    end
  end

  private

  def initial_params
    accepted_params = {}
    accepted_params[:inventory_id] = params[:inventory_id]
    accepted_params[:event_id] = params[:event_id]
    12.times do |p|
      next unless params["badge_#{p}"] != ''

      accepted_params["rating_#{p}"] = if params["rating_#{p}"] != ''
                                         params["rating_#{p}"]
                                       else
                                         1
                                       end
      accepted_params["badge_#{p}"] = params["badge_#{p}"]
    end

    params.require(accepted_params)
  end

  def update_params
    params.require(:game_log).permit(:rating)
  end
end
