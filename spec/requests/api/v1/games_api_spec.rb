require "rails_helper"

describe "games api" do
  let(:user)         { create(:user) }
  let(:invited_user) { create(:user) }
  it "shows games index" do
    create_list(:game, 3)

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }

    get "/api/v1/games", headers: headers

    result = JSON.parse(response.body)

    expect(response).to be_success

    expect(result).to be_an Array
    expect(result.count).to eq(3)
    expect(result[0]["player_1_board"]).to be_a Hash
    expect(result[0]["player_2_board"]).to be_a Hash
    expect(result[0]["player_1_board"]["rows"].count).to eq(4)
    expect(result[0]["player_2_board"]["rows"].count).to eq(4)
  end

  it "can create game" do
    create_list(:game, 3)

    headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
    params = {difficulty: 4}.to_json

    post "/api/v1/games",params: params, headers: headers

    expect(response).to be_success

    result = JSON.parse(response.body)

    expect(result).to be_a Hash
    expect(result["id"]).to eq(7)
    expect(result["current_turn"]).to eq("player_1")
  end
end
