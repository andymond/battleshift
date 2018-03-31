module Api
  module V1
    module Games
      class ShotsController < ApiController

        def create
          user_id = request.headers["HTTP_X_API_KEY"]
          user = User.find(user_id)
          game = user.games.find(params[:game_id])
          current_player = user.player_number(game.id)
          turn_processor = TurnProcessor.new(game, params[:shot][:target])
          if game.winner
            render json: game, status: 400, message: Printer.new(game, user).game_finished
          else
            if current_player == game.current_turn
              turn_processor.run!
              if turn_processor.message.include?("Game over")
                game.update_attributes(winner: user.email)
                render json: game, message: turn_processor.message
              else
                if turn_processor.message.include?("Invalid")
                  render json: game , status: 400, message: turn_processor.message
                else
                  render json: game, message: turn_processor.message
                end
              end
            else
              render json: game , status: 400, message: "Invalid move. It's your opponent's turn"
            end
          end
        end

      end
    end
  end
end
