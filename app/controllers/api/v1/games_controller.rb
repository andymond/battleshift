module Api
  module V1
    class GamesController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, :with => :game_not_found

      def index
        games = Game.all
        render json: games
      end

      def create
        game = Game.new(player_1_board: Board.new, player_2_board: Board.new)
        if game.save
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
    end
  end
end
