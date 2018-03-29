module Api
  module V1
    module Games
      class ShotsController < ApiController

        def create
          user_id = request.headers["HTTP_X_API_KEY"]
          user = User.find(user_id)
          game = user.games.find(params[:game_id])
          turn_processor = TurnProcessor.new(game, params[:shot][:target])

          turn_processor.run!

          render json: game, message: turn_processor.message
        end
      end
    end
  end
end
