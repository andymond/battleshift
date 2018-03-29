require "rails_helper"

describe "As a guest user" do
  describe "when I visit /" do
    it "I can register" do
      visit root_path

      fill_in "email", with: "arbitraryemail@thisisntreal.co"
      fill_in "name", with: "Opakawagalaga Eupanifahorious"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Create Account"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as Opakawagalaga Eupanifahorious")
      expect(page).to have_content("This account has not yet been activated")
      expect(page).to have_content("Please check your email")
      expect(User.count).to eq(1)
      expect(User.first.name).to eq("Opakawagalaga Eupanifahorious")
      expect(true).to be(true)
    end

    it "I can't register without the correct email" do
      visit root_path

      fill_in "name", with: "Opakawagalaga Eupanifahorious"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Create Account"

      expect(page).to have_content("We sunk your Battleship. Unable to create user account")
    end

    it "I can't register without the correct name" do
      visit root_path

      fill_in "email", with: "arbitraryemail@thisisntreal.co"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Create Account"

      expect(page).to have_content("We sunk your Battleship. Unable to create user account")
    end

    it "I can't register without the correct password" do
      visit root_path

      fill_in "email", with: "arbitraryemail@thisisntreal.co"
      fill_in "name", with: "Opakawagalaga Eupanifahorious"
      fill_in "password_confirmation", with: "password"
      click_on "Create Account"

      expect(page).to have_content("We sunk your Battleship. Unable to create user account")
    end

    it "I can't register without the correct password confirmation" do
      visit root_path

      fill_in "email", with: "arbitraryemail@thisisntreal.co"
      fill_in "name", with: "Opakawagalaga Eupanifahorious"
      fill_in "password", with: "password"
      click_on "Create Account"

      expect(page).to have_content("We sunk your Battleship. Unable to create user account")
    end

    it "I can't register without the correctly formated email" do
      visit root_path

      fill_in "email", with: "You'll never get me alive!"
      fill_in "name", with: "Opakawagalaga Eupanifahorious"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Create Account"

      expect(page).to have_content("We sunk your Battleship. Unable to create user account")
    end
  end
end
