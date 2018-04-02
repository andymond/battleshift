require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    let(:user)             { create(:user) }
    let(:user_2)           { create(:user) }
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:game)    { user.games.create(
                    player_1_board: player_1_board,
                    player_2_board: player_2_board,
                    current_turn: 0
                    )
                  }
    let!(:player_1) { game.colosseums.find_by(user_id: user.id).update_attribute(:gladiator_number, "player_1") }

    it "updates the message and board with a hit" do
      ship = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json
      game.colosseums.create(user_id: user_2.id, game_id: game.id, gladiator_number: 2)
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user_2.id}

      post "/api/v1/games/#{game.id}/ships", params: ship, headers: headers

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success
      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]

      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Miss. The computer's shot resulted in a Miss."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]

      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Miss")
    end

    it "updates the message but not the board with invalid coordinates" do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "X1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid coordinates. The computer's shot resulted in a Miss."
    end

    it "lets two players play each other" do
      current_user = spy('current_user')
      game.colosseums.create(user_id: user_2.id, game_id: game.id, gladiator_number: 2)
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      turn_1 = JSON.parse(response.body, symbolize_names: true)

      expect(current_user).to have_recieved(:player_number)
      expect(turn_1[:message]).to eq "Your shot resulted in a Miss."
      expect(turn_1[:player_2_board][:rows][1][:data][0][:status]).to eq("Miss")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user_2.id }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      turn_2 = JSON.parse(response.body, symbolize_names: true)

      expect(current_user).to have_recieved(:player_number)
      expect(turn_2[:message]).to eq "Your shot resulted in a Miss."
      expect(turn_2[:player_1_board][:rows][0][:data][0][:status]).to eq("Miss")
    end

    it "doesn't let user go twice in a row" do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      turn_1 = JSON.parse(response.body, symbolize_names: true)

      expect(turn_1[:message]).to include "Your shot resulted in a Miss."
      expect(turn_1[:player_2_board][:rows][1][:data][0][:status]).to eq("Miss")

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "A1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response.status).to eq(400)

      turn_2 = JSON.parse(response.body, symbolize_names: true)

      expect(turn_2[:message]).to eq "Invalid move. It's your opponent's turn"
      expect(turn_2[:player_2_board][:rows][0][:data][0][:status]).to eq("Not Attacked")
    end

    it "doesn't let users play other user's games" do
      different_game = double('game', id: 100)

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.id }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{different_game.id}/shots", params: json_payload, headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(result[:message]).to eq("Not Found")
    end
  end
end
