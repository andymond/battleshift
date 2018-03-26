require "rails_helper"

describe UserMailer, type: :mailer do
  context "as a non-activated user" do
    it "invites new user to activate their account with registration email" do
      email = UserMailer.activation_invite('player@example.com')

      email.deliver_now

      expect(email.from).to eq('donotreply@battlshift.com')
      expect(email.to).to eq('player@example.com')
      expect(email.subject).to eq('Activate your BattleShift account')
      expect(email.body).to eq(File.open('./spec/fixtures/user_mailer/activation.html'))
    end
  end
end
