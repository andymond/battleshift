class Printer

  def initialize(game, user)
    @game = game
    @user = user
  end

  def placed
    if check_contents == 3
      "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    else
      "Successfully placed ship with a size of 2. You have 0 ship(s) to place."
    end
  end

  def check_contents
    check_board.sum do |space|
      if space.values[0].contents
        1
      else
        0
      end
    end
  end

  def check_board
    if @user == 1
      @game.player_1_board.board.flatten
    else
      @game.player_2_board.board.flatten
    end
  end

  def game_over
    "Your shot resulted in a Hit. Battleship sunk. Game over. Congratulations #{@user.name}, you win! Come sail away!"
  end

  def game_finished
    "Invalid move. Game over. #{winner.name} won."
  end

  def winner
    @game.users.find_by(email: game.winner)
  end

end
