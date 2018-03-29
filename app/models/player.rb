class Player
  attr_reader :board, :user_id

  def initialize(user_id = nil, board)
    @user_id = user_id
    @board = board
  end
  
end
