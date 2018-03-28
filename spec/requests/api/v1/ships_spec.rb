require "rails_helper"

describe "Api::V1::Ships" do
  it "can place ships and stuff and also bombs but not really bombs mostly just ships but maybe later there will be bombs Andy can we do bombs? Please?" do
    game = create(:game)

    ship = {
      ship_size: 3,
      start_space: "A1",
      end_space: "A3"
    }.to_json
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/games/#{game.id}/ships", params: ship, headers: headers

    
  end
end
