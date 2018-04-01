class ApiController < ActionController::API
  before_action :validate_api_key

    def current_user
      User.find_by(id: request.headers["HTTP_X_API_KEY"])
    end

    def current_game
      @game ||= current_user.games.find(params[:game_id])
    end

    def current_board
      if current_game.player_1 == current_user.id
        current_game.player_1_board
      else
        current_game.player_2_board
      end
    end

    def validate_api_key
      not_found = {message: "Unauthorized"}
      unless User.find_by(id: request.headers["X-API-KEY"])
        render json: not_found, status: 401
      end
    end
end
