require "spec_helper"

RSpec.describe Mblackjack do
  it "has a version number" do
    expect(Mblackjack::VERSION).not_to be nil
  end

  it "diplays suit and rank for each card" do
    card1 = Card.new(5, 'H')
    expect(Card.show_suit_rank([card1])).to eq("5 of H, ")
  end
end
