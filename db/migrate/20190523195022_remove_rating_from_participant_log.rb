class RemoveRatingFromParticipantLog < ActiveRecord::Migration[5.2]
  def change
    remove_column :participant_logs, :rating, :integer
  end
end
