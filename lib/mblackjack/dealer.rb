class Dealer
  attr_accessor :dealer_hand

  def initialize
      @dealer_hand = Hand.new
  end
end
