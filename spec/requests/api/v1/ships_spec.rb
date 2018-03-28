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

    game = JSON.parse(response.body, symbolize_names: true)

    expect(game[:message]).to eq("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")
    expect(game[:id]).to be_an Integer
    expect(game[:current_turn]).to be_a String
    expect(game[:player_1_board][:rows].count).to eq(4)
    expect(game[:player_2_board][:rows].count).to eq(4)
    expect(game[:player_1_board][:rows][0][:name]).to eq("row_a")
    expect(game[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
    expect(game[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
    expect(game[:player_1_board][:rows][3][:data][0][:status]).to be_a String
  end
end