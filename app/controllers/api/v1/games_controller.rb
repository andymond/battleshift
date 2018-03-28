module Api
  module V1
    class GamesController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, :with => :game_not_found

      def index
        games = Game.all
        render json: games
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
