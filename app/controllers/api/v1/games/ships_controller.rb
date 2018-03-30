class Api::V1::Games::ShipsController < ApiController

  def create
    user = User.find(request.headers["HTTP_X_API_KEY"])
    game = user.games.find(params[:game_id])
    if game.player_1 == user.id
      ship = Ship.new(params[:ship][:ship_size])
      ship.place(params[:ship][:start_space], params[:ship][:end_space])
      board = game.player_1_board
      start_space = params[:ship][:start_space]
      end_space = params[:ship][:end_space]
      ShipPlacer.new(board: board, ship: ship, start_space: start_space, end_space: end_space).run
      game.save!
      binding.pry
      message = Printer.new(game, 1).placed
      render json: game, message: message
    else
      ship = Ship.new(params[:ship][:ship_size])
      ship.place(params[:ship][:start_space], params[:ship][:end_space])
      board = game.player_2_board
      start_space = params[:ship][:start_space]
      end_space = params[:ship][:end_space]
      ShipPlacer.new(board: board, ship: ship, start_space: start_space, end_space: end_space).run
      game.save!
      message = Printer.new(game, 2).placed
      render json: game, message: message
    end
  end

end
