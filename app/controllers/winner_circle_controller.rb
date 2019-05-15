class WinnerCircleController < ApplicationController
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

  @@redraws = Hash.new

  def pick_winners
    @entries = Array.new

    Inventory.all.length.times do |i|
      @checklog = GameLog.where(inventory_id: i + 1).index_by { |r| r[:participant_id]}.values

      @@redraws[Inventory.all[i].id] = @checklog

      if @checklog != []
        @winner = @checklog[Random.rand(@checklog.length)]
        @contact = Participant.where(id: @winner[:participant_id])

        @winner_json = @winner.as_json
        @contact_json = @contact.as_json

        @winner_array = @winner_json.to_a
        @contact_json.push(@winner_array[2])

        @entries.push(@contact_json)
      else
        @entries.push("No entry")
      end
    end

    render json: { winners: @entries }
  end

  def redraw_winner
    @game = params[:inventory_id]
    @redraw = @@redraws.keep_if do |i|
      @@redraws[i] != []
    end
    @entry = @redraw[@game]

    if @redraw.empty?
      render json: { error: "Must pick winners first." }
    else
      render json: { redraw: @redraw, test_1: @entry }
    end
  end

end