class Printer

  def initialize(game)
    @game = game
  end

  def placed
    if check_contents == 3
      "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    else
      "Successfully placed ship with a size of 2. You have 0 ship(s) to place."
    end
  end

  def check_contents
    @game.player_1_board.board.flatten.sum do |space|
      if space.values[0].contents
        1
      else
        0
      end
    end
  end


end
