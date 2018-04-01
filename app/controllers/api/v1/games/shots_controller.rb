module Api
  module V1
    module Games
      class ShotsController < ApiController
        before_action :game_over?
        before_action :current_turn

        def create
          turn_processor = TurnProcessor.new(current_game, params[:shot][:target])
          turn_processor.run!
          if turn_processor.message.include?("Game over")
            current_game.update_attributes(winner: current_user.email)
            render json: current_game, message: turn_processor.message
          else
            if turn_processor.message.include?("Invalid")
              render json: current_game , status: 400, message: turn_processor.message
            else
              render json: current_game, message: turn_processor.message
            end
          end
        end

        private

          def game_over?
            if current_game.winner
              render json: current_game, status: 400, message: Printer.new(current_game, current_user).game_finished
            end
          end

          def current_player
            @current_player ||= current_user.player_number(current_game.id)
          end

          def current_turn
            unless current_player == current_game.current_turn
            render json: current_game , status: 400, message: "Invalid move. It's your opponent's turn"
            end
          end
      end
    end
  end
end
