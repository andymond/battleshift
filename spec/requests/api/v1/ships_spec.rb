require "rails_helper"

describe "Api::V1::Ships" do
  it "can place ships and stuff and also bombs but not really bombs mostly just ships but maybe later there will be bombs Andy can we do bombs? Please?" do
    game = create(:game)

    post "api/v1/#{game.id}/ships", data: ""
  end
end
