require "rails_helper"

describe Board, type: :model do
  it "initializes with correct attributes" do
    board = Board.new

    expect(board.length).to eq(4)
    expect(board.board.class).to eq(Array)
    expect(board.board.flatten.class).to eq(Array)
    expect(board.board.flatten[0].class).to eq(Hash)
    board.board.flatten.each do |board_space|
      expect(board_space.values[0].class).to eq(Space)
      expect(board_space.values[0].contents).to eq(nil)
      expect(board_space.values[0].status).to eq("Not Attacked")
    end
  end

  it "initializes with different length" do
    board = Board.new(5)

    expect(board.length).to eq(5)
    expect(board.board.flatten.count).to eq(25)
  end

  it "has a max size of 26" do
    board = Board.new(29)

    expect(board.board.first.class).to eq(Array)
    expect(board.board.first.count).to eq(26)
  end

  it "can tell if all ships are sunk" do
    board = Board.new
    ship = Ship.new(2)
    ship.place("A1", "A2")
    ship_2 = Ship.new(3)
    ship_2.place("B1", "B3")
    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
    ShipPlacer.new(board: board, ship: ship_2, start_space: "B1", end_space: "B3").run

    expect(board.all_sunk?).to eq(false)
  end

  it "defaults to board size 4" do
    board = Board.new(0)

    expect(board.length).to eq(4)
  end
end
