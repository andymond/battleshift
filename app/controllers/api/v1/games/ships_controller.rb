class Api::V1::Games::ShipsController < ApiController

  def create
    game = Game.last
    ship = Ship.new(params[:ship][:ship_size])
    ship.place(params[:ship][:start_space], params[:ship][:end_space])
    board = game.player_1_board
    start_space = params[:ship][:start_space]
    end_space = params[:ship][:end_space]
    ShipPlacer.new(board: board, ship: ship, start_space: start_space, end_space: end_space).run
    message = "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    render body: {message: message}
  end

end
