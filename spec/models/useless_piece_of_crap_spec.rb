require "rails_helper"

describe UselessPieceOfCrap, type: :model do
  it "is useless" do
    why_even = UselessPieceOfCrap.new("Literally anything here")

    expect(why_even.class).to eq(UselessPieceOfCrap)
    expect(why_even.do_you_do_anything?).to eq("I made you give me an argument")
    expect(why_even.but_seriously).to eq(100)
  end
end
