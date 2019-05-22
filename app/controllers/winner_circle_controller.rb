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

  def grab_logs()
    @checklog = Hash.new
    Inventory.all.length.times { |i|
      @checklog[i] = GameLog.where(inventory_id: i + 1).uniq { |r| r[:participant_id]}
      if @checklog[i] == []
        @checklog[i] = "No entry"
      end
    }
  end

  def define_logs
    @checklog.each_key { |i|
      if @checklog[i] != "No entry"
        @checklog[i].as_json.length.times { |y|
          front_end = ["rating","inventory_id","badge","name","phone","email","pref","proxy","p_badge","p_name","p_phone","p_email","p_pref"]

          @checklog[i][y] = @checklog[i][y].as_json.merge(Participant.where(id: @checklog[i][y]["participant_id"].to_i).as_json[0])
          @checklog[i][y].keep_if { |k,v| front_end.include? k }

          @checklog[i][y].each_key { |k|
            if @checklog[i][y][k] == nil
              @checklog[i][y][k] = ""
            end
          }
        }
      end
    }
  end

  def select_winners
    @checklog.each_key { |key|
      if @checklog[key] != "No entry"
        @winner[key + 1] = @checklog[key].as_json[Random.rand(@checklog[key].length)]
      else
        @winner[key + 1] = @checklog[key]
      end
    }
  end

  def show_winners
    grab_logs
    define_logs
    @winner = Hash.new
    select_winners

    render json: {winners: @winner}
  end

  def redraw_winner
    @game = params[:title_id]
    @won = params[:badge_id]

    grab_logs
    define_logs

    if @won != "undefined"
      if @checklog[@game.to_i - 1].length > 1
        @checklog[@game.to_i - 1].length.times { |game_entry|
          if @checklog[@game.to_i - 1].as_json[game_entry]["badge"] == @won.to_i
            @checklog[@game.to_i - 1][game_entry].delete(game_entry)
          end
        }

        @winner = @checklog[@game.to_i - 1].as_json[Random.rand(@checklog[@game.to_i - 1].length)]

        render json: { new_winner: @winner}
      else
        render json: { error: "No other winners." }
      end
    else
      render json: { error: "No entries logged for this title."}
    end
  end

end