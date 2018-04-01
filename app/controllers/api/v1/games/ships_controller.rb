class Api::V1::Games::ShipsController < ApiController

  def create
    ship = Ship.new(params[:ship][:ship_size])
    ship.place(params[:ship][:start_space], params[:ship][:end_space])
    ShipPlacer.new(placement_params).run
    current_game.save!
    if current_game.player_1 == current_user.id
      message = Printer.new(current_game, 1).placed
    else
      message = Printer.new(current_game, 2).placed
    end
    render json: current_game, message: message
  end

  private

    def placement_params
      {
        board: current_board,
        ship: Ship.new(params[:ship][:ship_size]),
        start_space: params[:ship][:start_space],
        end_space: params[:ship][:end_space]
      }
    end

end
