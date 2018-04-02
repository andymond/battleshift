module Api
  module V1
    class GamesController < ApiController
      rescue_from ActiveRecord::RecordNotFound, :with => :game_not_found

      def index
        games = Game.all
        render json: games
      end

      def create
        player_1 = current_user
        player_2 = User.find_by(email: params[:opponent_email])
        game = Game.new(game_params)
        if game.save
          game.colosseums.create(user_id: player_1.id, gladiator_number: 1)
          game.colosseums.create(user_id: player_2.id, gladiator_number: 2) unless player_2.nil?
          render json: game
        else
          failure = {message: "couldn't create game"}
          render json: failure
        end
      end

      def show
        game = Game.find(params[:id])
        render json: game
      end

      private

        def game_not_found
          render status: 404
        end

        def game_params
          {
            current_turn: 0,
            player_1_board: Board.new(params[:difficulty].to_i),
            player_2_board: Board.new(params[:difficulty].to_i)
          }
        end
    end
  end
end
