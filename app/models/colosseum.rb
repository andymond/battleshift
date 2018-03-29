class Colosseum < ApplicationRecord
  belongs_to :game
  belongs_to :user
  enum gladiator_number: { player_1: 1, player_2: 2 }
end
