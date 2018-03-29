class ChangeDefaultTurnCountInGame < ActiveRecord::Migration[5.1]
  def change
    change_column_default :games, :player_1_turns, 0
    change_column_default :games, :player_2_turns, 0
  end
end
