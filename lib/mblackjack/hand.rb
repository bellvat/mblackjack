class Hand
  attr_accessor :hand_no, :cards_in_hand, :bet, :choices, :hand_value

  def initialize
    @hand_no = hand_no
    @cards_in_hand = []
    @bet = 0
    @choices = []
    @hand_value = 0
  end

  #Could be improved
  def calc_hand_value
    @hand_value = 0
    cards_in_hand.each_with_index do |c,ind|
      if c != "ace"
        value = Deck.card_values.fetch(c)
        @hand_value += value
      elsif c == "ace" && cards_in_hand[ind -1] == "ace"
        value = Deck.card_values.fetch(c)[0]
        @hand_value += value
      elsif c == "ace"
        value = Deck.card_values.fetch(c)[1]
        @hand_value += value
      end
    end
    if @hand_value > 21 and cards_in_hand.include?("ace")
      @hand_value -= 10
    end
  end
end
