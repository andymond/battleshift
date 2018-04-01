require 'rails_helper'

describe "As a registered User" do
  before :each do
    user = create(:user, status: 1)
    user.games.create!(player_1_board: Board.new, player_2_board: Board.new, winner: user.email)
    user.games.create!(player_1_board: Board.new, player_2_board: Board.new, winner: "losingemail@email.com")
    user.games.create!(player_1_board: Board.new, player_2_board: Board.new)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
  end
  describe "when I visit my dashboard page" do
    it "I can create a new game" do
      click_on "New Game"

      expect(current_path).to eq(new_game_path)
      expect(page).to have_content("Difficulty")
      expect(page).to have_content("Opponent email")
    end

    it "I can see how many wins I've had" do
      expect(page).to have_content("Wins 1")
    end

    it "I can see how many losses I've had" do
      expect(page).to have_content("Losses 1")
    end

    it "I can see my win/loss percentage" do
      expect(page).to have_content("W/L Percentage 50%")
    end

    it "I can see the games I'm currently playing" do
      expect(page).to have_content("Game #1")
      expect(page).to_not have_content("Game #2")
    end
  end
end
