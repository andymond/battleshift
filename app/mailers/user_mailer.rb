class UserMailer < ApplicationMailer
  default from: 'donotreply@battleshift.com'

  def activation_invite(user)
    @user = user
    @url = "#{ENV['ROOT']}/activation/#{@user.id}"
    mail(to: @user.email, subject: 'Activate your BattleShift account')
  end

  def game_invite(email, user)
    @user = user
    @url = "#{ENV['ROOT']}/games/#{user.games.last.id}"
    mail(to: email, subject: "You have been invited to a game of BattleShift!")
  end

  def register_invite(email, user)
    @user = user
    @url = "#{ENV['ROOT']}/register"
    mail(to: email, subject: "You have been invited to a game of BattleShift!")
  end

end
