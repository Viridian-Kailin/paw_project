class AddRatingtoParticipantLog < ActiveRecord::Migration[5.2]
  def change
    add_column :participant_logs, :rating, :integer
  end
end
