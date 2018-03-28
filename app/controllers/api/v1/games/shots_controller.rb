module Api
  module V1
    module Games
      class ShotsController < ApiController
        before_action :api_key_validation

        def create
          game = Game.find(params[:game_id])

          turn_processor = TurnProcessor.new(game, params[:shot][:target])

          turn_processor.run!

          render json: game, message: turn_processor.message
        end

        private

          def api_key_validation
            not_found = {message: "Unauthorized"}
            unless User.find_by(id: request.headers["X-API-KEY"])
              render json: not_found, status: 401
            end
          end
      end
    end
  end
end
