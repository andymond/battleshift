class TurnProcessor
  attr_reader :status

  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
    @status = 200
  end

  def run!
    begin
      attack_opponent(being_attacked)
      player_2.user_id.nil? ? ai_attack_back : nil
      change_turn
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
      @status = 400
      player_2.user_id.nil? ? ai_attack_back : nil
    end
  end

  def message
    @messages.join(" ")
  end

  private

    attr_reader :game, :target

    def attack_opponent(player)
      result = Shooter.fire!(board: player.board, target: target)
      count_turn(player)
      @messages << "Your shot resulted in a #{result}."
      @messages << "Battleship sunk." if sunk?(result, player.board)
      @messages << "Game over." if sunk_count(player.board) == 5
    end

    def being_attacked
      if game.current_turn == "player_1"
        player_2
      else
        player_1
      end
    end

    def change_turn
      if game.current_turn == "player_1"
        game.current_turn = "player_2"
      else
        game.current_turn = "player_1"
      end
    end

    def count_turn(player)
      if game.player_1_board == player.board
        game.player_1_turns += 1
      else
        game.player_2_turns += 1
      end
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

    def sunk?(result, board)
      if result == "Hit"
        board.board.flatten.any? do |space_hash|
          space_hash.values[0].contents.is_sunk? if space_hash.keys == [target]
        end
      else
        false
      end
    end

    def sunk_count(board)
      board.board.flatten.count do |space_hash|
        space_hash.values[0].contents.is_sunk? if space_hash.values[0].occupied?
      end
    end

end
