require "rails_helper"

describe "games api" do
  it "shows a list of games" do
    create_list(:game, 3)

    get "/api/v1/games"

    result = JSON.parse(response.body)

    expect(result).to be_an Array
    expect(result.count).to eq(3)
    expect(result[0]["player_1_board"]).to be_a Hash
    expect(result[0]["player_2_board"]).to be_a Hash
    expect(result[0]["player_1_board"]["rows"].count).to eq(4)
    expect(result[0]["player_2_board"]["rows"].count).to eq(4)
  end
end
