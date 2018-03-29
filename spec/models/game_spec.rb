require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should validate_presence_of(:player_1_board) }
  it { should validate_presence_of(:player_2_board) }
  it { should have_many(:colosseums) }
  it { should have_many(:users).through(:colosseums) }

  describe "scopes" do
    it "player_1 returns colosseum with user_id" do
      user_1 = create(:user)
      user_2 = create(:user)
      game   = create(:game)
      colosseum_1 = game.colosseums.create(user_id: user_1.id, gladiator_number: 1)
      colosseum_2 = game.colosseums.create(user_id: user_2.id, gladiator_number: 2)

      expect(game.player_1).to eq(colosseum_1.user_id)
      expect(game.player_2).to eq(colosseum_2.user_id)
    end

  end
end
