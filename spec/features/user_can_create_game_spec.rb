require "rails_helper"

describe "user can create game" do
  context "active, registered user" do
    it "can create game against another registered user" do
      user = create(:user, status: 1)
      user_2 = create(:user, status: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      click_on "New Game"

      expect(current_path).to eq("/games/new")

      select "Easy", from: "Difficulty"
      fill_in "Opponent email", with: user_2.email
      click_on "Invite your Opponent"

      expect(current_path).to eq("/games/1")
      expect(page).to have_content("Place your ships")
      expect(page).to have_link("Finished turn")
    end

    it "can't create game against unregistered user" do
      user = create(:user, status: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      click_on "New Game"

      expect(current_path).to eq("/games/new")

      select "Easy", from: "Difficulty"
      fill_in "Opponent email", with: "random@person.com"
      click_on "Invite your Opponent"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("We invited your friend @ random@person.com to join Battleshift!")
    end
  end

  context "inactive, registered user" do
    it "can't create game" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_game_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You must activate your account!")
    end
  end
end
