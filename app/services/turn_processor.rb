class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
  end

  def being_attacked
    game.current_turn == "player_1" ? player_2 : player_1
  end

  def change_turn
    game.current_turn == "player_1" ? game.current_turn = 1 : game.current_turn = 0
  end

  def run!
    begin
      attack_opponent(being_attacked)
      player_2.user_id.nil? ? ai_attack_back : nil
      change_turn
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
      player_2.user_id.nil? ? ai_attack_back : nil
    end
  end

  def message
    @messages.join(" ")
  end

  def game_over_player_1?
    if game.player_1_board.all_ships_sunk?
      Printer.new(game).game_over_player_2_win
    else
      false
    end
  end

  def game_over_player_2?
    if game.player_2_board.all_ships_sunk?
      Printer.new(game).game_over_player_1_win
    else
      false
    end
  end

  private

  attr_reader :game, :target

  def attack_opponent(player)
    result = Shooter.fire!(board: player.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_board ? game.player_1_turns += 1 : game.player_2_turns += 1
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player_1.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def player_1
    Player.new(game.player_1, game.player_1_board)
  end

  def player_2
    Player.new(game.player_2, game.player_2_board)
  end

end
