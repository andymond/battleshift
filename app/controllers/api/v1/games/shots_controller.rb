module Api
  module V1
    module Games
      class ShotsController < ApiController

        def create
          user_id = request.headers["HTTP_X_API_KEY"]
          user = User.find(user_id)
          game = user.games.find(params[:game_id])
          current_player = user.player_number(game.id)
          render json: game, status: 400, message: Printer.new(game, user).game_finished if game.winner
          turn_processor = TurnProcessor.new(game, params[:shot][:target])
          if current_player == game.current_turn
            turn_processor.run!
            if game.player_1_board.all_sunk?
              game.winner = game.users.find(game.player_2).email
              render json: game, message: Printer.new(game, user).game_over
            elsif game.player_2_board.all_sunk?
              game.winner = game.users.find(game.player_1).email
              render json: game, message: Printer.new(game, user).game_over
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
