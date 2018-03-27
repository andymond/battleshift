class UserMailer < ApplicationMailer
  default from: 'donotreply@battleshift.com'

  def activation_invite(user)
    @user = user
    @url = "#{ENV['root']}/activate/#{@user.id}"
    mail(to: @user.email, subject: 'Activate your BattleShift account')
  end

  def game_invite(email, user)
    @user = user
    @url = "#{ENV['root']}/games/#{user.games.last.id}"
    mail(to: email, subject: "You have been invited to a game of BattleShift!")
  end

  def register_invite(email, user)
    @user = user
    @url = "#{ENV['root']}/register"
    mail(to: email, subject: "You have been invited to a game of BattleShift!")
  end

end
