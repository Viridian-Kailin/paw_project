# frozen_string_literal: true

#:nodoc:
class GameLogsController < ApplicationController
  skip_before_action :admin, only: [:index, :new, :create, :need_reg]

  def new
    @logs = GameLog.new
  end

  def index
    @logs = GameLog.log_info(GameLog.all)
  end

  def edit
    @log = GameLog.find(params[:id])
    @title = Inventory.find(@log[:inventory_id])
    @member = Participant.find(@log[:participant_id])
    @log_event = Event.find(@log[:event_id])
  end

  def update
    @log = GameLog.update_record(params[:id])
    if @log.update(update_params)
      flash[:notice] = 'GameLog updated.'
      redirect_to game_logs_path
    else
      flash[:alert] = 'Unable to save edit.'
      render 'edit'
    end
  end

  def destroy
    GameLog.destroy_record(params[:id])
    flash[:notice] = 'Single game log entry has been deleted.'
    redirect_to game_logs_path
  end

  def timestamp
    @logs_timestamp = DateTime.new(
      params['timestamp(1i)'].to_i,
      params['timestamp(2i)'].to_i,
      params['timestamp(3i)'].to_i,
      params['timestamp(4i)'].to_i,
      params['timestamp(5i)'].to_i
    )
  end

  def static_values
    timestamp
    @static = { inventory_id: params[:inventory_id].to_i,
                event_id: params[:event_id].to_i,
                timestamp: @logs_timestamp }
  end

  def count_entries
    initial_params
    @accepted_params = {}
    @member = {}
    params.each { |k, v| @member[k.split('_')[1]] = v if k.start_with?('badge_') }

    @member.length.times do |i|
      @accepted_params[i] = { participant_id: Participant.where(badge: @member[i.to_s])[0][:id], rating: params["rating_#{i}"] || 1 }
    end
  end

  def convert_entries
    count_entries
    static_values

    @accepted_params.length.times do |c|
      @accepted_params[c].merge!(@static)
    end
  end

  def create
    convert_entries
    @accepted_params.length.times do |i|
      @new_log = GameLog.new(@accepted_params[i])
      if @new_log.save
        flash[:notice] = "Entry for #{Inventory.find(@accepted_params[i][:inventory_id])[:title]} at #{@logs_timestamp} has been added."
      else
        flash[:error] = @log.errors.full_messages
      end
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
    params.keep_if { |_k, v| v != '' }

    params.each { |k, _v| params.require(k) }
  end

  def update_params
    params.require(:game_log).permit(:rating)
  end
end
