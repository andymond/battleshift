class GamesController < ApplicationController
  before_action :require_activation, only: [:new, :show]

  def show
    @game = Game.find(params[:id])
  end

  def new
  end

  def create
    new_game = current_user.games.create(player_1_board: Board.new(params[:difficulty].to_i), player_2_board: Board.new(params[:difficulty].to_i))
    current_user.colosseums.last.update_attribute(:gladiator_number, 1)
    invited_user = User.find_by(email: params[:opponent_email])
    if invited_user
      Colosseum.create(user_id: invited_user.id, game_id: new_game.id, gladiator_number: 2)
      UserMailer.game_invite(params[:opponent_email], current_user)
      redirect_to game_path(new_game)
    else
      UserMailer.register_invite(params[:opponent_email], current_user)
      flash[:notice] = "We invited your friend @ #{params[:opponent_email]} to join Battleshift!"
      redirect_to dashboard_path
    end
  end

  private

    def require_activation
      unless current_user.active?
        redirect_to dashboard_path, alert: "You must activate your account!"
      end
    end

end
