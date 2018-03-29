class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["player_1", "player_2"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  has_many :colosseums
  has_many :users, through: :colosseums

  def player_1
    player = colosseums.where("gladiator_number = ?", 1).first
    player.user_id unless player.nil?
  end

  def player_2
    player = colosseums.where("gladiator_number = ?", 2).first
    player.user_id unless player.nil?
  end

end
