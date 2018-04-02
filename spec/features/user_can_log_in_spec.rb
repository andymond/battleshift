require "rails_helper"

describe "user can log in" do
  context "an existing user" do
    it "can log in" do
      user = create(:user, status: 1)
      visit root_path

      find('.login-button').click

      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Log In"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome #{user.name}!")
    end
  end

  context "an unregistered user" do
    it "can't log in" do
      visit root_path

      click_on "Log in"

      expect(current_path).to eq(login_path)
      fill_in "email", with: "user"
      fill_in "password", with: "password"
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Miss! Invalid Credentials")
    end
  end
end
