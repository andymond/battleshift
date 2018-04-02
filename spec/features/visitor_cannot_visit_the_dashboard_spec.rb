require 'rails_helper'

describe "As a visitor" do
  describe "when I try to visit the dashboard" do
    it "I am redirected back to the root path" do
      visit dashboard_path

      expect(current_path).to eq(root_path)
    end
  end
end
