require_relative 'card.rb'

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
  def calc_hand_value(hand)
    @hand_value = 0
    #ace can be 1 or 11, i want the program to find the value that is closest to but not exceeding 21
    all_values = []
    ranks = []
    value2 = 0
    target = 21
    hand.each do |card|
      if card.rank == "ace"
        Card.values[card.rank].each do |a|
          ranks << [a]
        end
      else
        ranks << Card.values[card.rank]
      end
      p cards
    end
  #  p ranks
    #all_values.push(value,value2)
    #p all_values
    #p all_values.select {|v| v <= 21}

  end

end

hand1 = Hand.new
card1 = Card.new(2,'S')

card2 = Card.new('ace','S')
card3 = Card.new('ace','S')
card4 = Card.new(9,'S')
hand1.calc_hand_value([card1,card2,card3,card4])
