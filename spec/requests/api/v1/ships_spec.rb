require "rails_helper"

describe "Api::V1::Ships" do
  let(:user) { create(:user) }
  it "can place ships and stuff and also bombs but not really bombs mostly just ships but maybe later there will be bombs Andy can we do bombs? Please?" do
    game = create(:game)

    ship = {
      ship_size: 3,
      start_space: "A1",
      end_space: "A3"
    }.to_json
    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }

    post "/api/v1/games/#{game.id}/ships", params: ship, headers: headers

    ship = JSON.parse(response.body, symbolize_names: true)

    expect(ship[:message]).to eq("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")
    expect(ship[:id]).to be_an Integer
    expect(ship[:current_turn]).to be_a String
    expect(ship[:player_1_board][:rows].count).to eq(4)
    expect(ship[:player_2_board][:rows].count).to eq(4)
    expect(ship[:player_1_board][:rows][0][:name]).to eq("row_a")
    expect(ship[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
    expect(ship[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
    expect(ship[:player_1_board][:rows][3][:data][0][:status]).to be_a String

    ship_2 = {
      ship_size: 2,
      start_space: "B1",
      end_space: "C1"
    }.to_json

    post "/api/v1/games/#{game.id}/ships", params: ship_2, headers: headers

    ship_2 = JSON.parse(response.body, symbolize_names: true)

    expect(ship_2[:message]).to include("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")
  end
end
