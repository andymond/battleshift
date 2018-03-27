require "rails_helper"

describe UserMailer, type: :mailer do
  context "actions" do
    it "#activation_invite" do
      user = create(:user)
      email = UserMailer.activation_invite(user)

      email.deliver_now

      expect(email.from).to eq(['donotreply@battleshift.com'])
      expect(email.to).to eq([user.email])
      expect(email.subject).to eq('Activate your BattleShift account')
      expect(email.body.encoded).to include("Thanks for signing up #{user.name}!")
      expect(email.body.encoded).to include("Click here to activate your account")
      expect(email.body.encoded).to include("Your api key is: #{user.id}, please keep it secret.")
    end

    it "#game_invite" do
      user = create(:user, status: 1)
      user.games.create()
      email = UserMailer.game_invite("fake@fake.com", user)

      email.deliver_now

      expect(email.from).to eq(['donotreply@battleshift.com'])
      expect(email.to).to eq(['fake@fake.com'])
      expect(email.subject).to eq("You have been invited to a game of BattleShift!")
      expect(email.body.encoded).to include("#{user.name} has invited you to a game of BattleShift!")
      expect(email.body.encoded).to include("Join Game")
    end

    it "#register_invite" do
      user = create(:user, status: 1)
      user.games.create()
      email = UserMailer.register_invite("fake@fake.com", user)

      email.deliver_now

      expect(email.from).to eq(['donotreply@battleshift.com'])
      expect(email.to).to eq(['fake@fake.com'])
      expect(email.subject).to eq("You have been invited to a game of BattleShift!")
      expect(email.body.encoded).to include("#{user.name} has invited you to a game of BattleShift, but you must register first!")
      expect(email.body.encoded).to include("Register Here")
      expect(email.body.encoded).to include("Then invite them to a new game!")
    end
  end
end
