require "rails_helper"

describe "api key verification" do
  let(:user)           { create(:user) }
  let(:player_1_board) { Board.new(4) }
  let(:player_2_board) { Board.new(4) }
  let(:sm_ship)        { Ship.new(2) }
  let(:game)           { create(:game,
                         player_1_board: player_1_board,
                         player_2_board: player_2_board)
                       }

  it "user visits endpoint without key" do
    headers = { "CONTENT_TYPE" => "application/json" }
    json_payload = {target: "A1"}.to_json

    post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

    result = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(result["message"]).to eq("Unauthorized")
  end

  it "user visits endpoint with key" do
    headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => user.id }
    json_payload = {target: "A1"}.to_json

    post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

    result = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(result["message"]).to eq("Your shot resulted in a Miss. The computer's shot resulted in a Miss.")
  end
end
