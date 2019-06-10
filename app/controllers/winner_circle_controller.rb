# frozen_string_literal: true

class WinnerCircleController < ApplicationController
  skip_before_action :admin

  attr_reader :badge
  attr_reader :name
  attr_reader :phone
  attr_reader :email
  attr_reader :pref
  attr_reader :proxy
  attr_reader :p_badge
  attr_reader :p_name
  attr_reader :p_email
  attr_reader :p_phone
  attr_reader :p_pref

  # Only keep the highest rated log for duplicate entries.

  def grab_logs
    @checklog = {}
    Inventory.all.length.times do |i|
      @checklog[i] = GameLog.where(inventory_id: i + 1).uniq { |r| r[:participant_id] }
      @checklog[i] = 'No entry' if @checklog[i] == []
    end
  end

  def define_logs
    @checklog.each_key do |i|
      next unless @checklog[i] != 'No entry'

      @checklog[i].as_json.length.times do |y|
        front_end = %w[rating inventory_id badge name phone email pref proxy p_badge p_name p_phone p_email p_pref]

        @checklog[i][y] = @checklog[i][y].as_json.merge(Participant.where(id: @checklog[i][y]['participant_id'].to_i).as_json[0])
        @checklog[i][y].keep_if { |k, _v| front_end.include? k }

        @checklog[i][y].each_key do |k|
          @checklog[i][y][k] = '' if @checklog[i][y][k].nil?
        end
      end
    end
  end

  def select_winners
    @checklog.each_key do |key|
      if @checklog[key] != 'No entry'
        @checklog[key].each_index do |entry|
          ActiveLog.create(@checklog[key][entry])
        end

        @winner[key + 1] = @checklog[key].as_json[Random.rand(@checklog[key].length)]
      else
        @winner[key + 1] = @checklog[key]
      end
    end
  end

  def show_winners
    grab_logs
    define_logs
    @winner = {}
    select_winners

    render json: { winners: @winner, test_1: @checklog }
  end

  def redraw_winner
    @game = params[:title_id].to_i
    @won = params[:badge_id]

    if @won != 'undefined'
      if ActiveLog.where(inventory_id: @game).length > 1
        ActiveLog.where(inventory_id: @game, badge: @won.to_i).delete_all
        @new_winner = ActiveLog.where(inventory_id: @game).as_json[Random.rand(ActiveLog.where(inventory_id: @game).length)]

        render json: { new_winner: @new_winner }
      else
        render json: { error: 'No other winners.' }
      end
    else
      render json: { error: 'No entries logged for this title.' }
    end
  end

  private
end
