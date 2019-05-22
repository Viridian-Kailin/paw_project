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

    byebug

    grab_logs
    define_logs

    @checklog[@game.to_i - 1].length.times { |i|
      if @checklog[@game.to_i - 1].as_json[i]["badge"] == @won.to_i
          @checklog[@game.to_i - 1].delete_at(i)
      end
    }

    @winner = Hash.new
    @checklog[@game.to_i].each_key { |key|
      if @checklog[key] != "No entry"
        @winner[key + 1] = @checklog[key].as_json[Random.rand(@checklog[key].length)]
      else
        @winner[key + 1] = @checklog[key]
      end
    }

    render json: { test_1: @won, test_2: @game, test_3: @winner[@game.to_i]}
  end

end