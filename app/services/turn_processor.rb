class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
  end

  def run!
    begin
      attack_opponent
      opponent.user_id.nil? ? ai_attack_back : player_2_attack
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
      opponent.user_id.nil? ? ai_attack_back : player_2_attack
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent #accept current_player as param?
    result = Shooter.fire!(board: opponent.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_turns += 1
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def player
    user_id = game.colosseums.first.user_id unless game.colosseums.empty?
    Player.new(user_id, game.player_1_board)
  end

  def opponent
    user_id = game.colosseums.last.user_id unless game.colosseums.empty?
    Player.new(user_id, game.player_2_board)
    binding.pry
  end

end
