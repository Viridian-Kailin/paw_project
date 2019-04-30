class GameLog < ApplicationRecord
  validates :title, presence: true
  serialize :entry, JSON

  def entry_params
    @badgerating_array = Array.new

    for i in 1..12
      if params[:entry]["badge_#{i}"].blank? == false
        add_badge = params[:entry]["badge_#{i}"].to_i

        @badgerating_array.push params[:entry]["badge_#{i}"].to_i => params[:entry]["rating_#{i}"].to_i
      end
    end
  end



end
