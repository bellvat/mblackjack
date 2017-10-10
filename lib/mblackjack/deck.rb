require_relative 'card.rb'

class Deck
  attr_accessor :deck
  def initialize
    @deck = []
    make_deck(Card.suits, Card.ranks)
  end

  def make_deck(suits, ranks)
      suits.each do |s|
        ranks.each do |r|
          @deck << Card.new(r,s)
        end
      end
  end

  def shuffle
    deck.shuffle!
  end

end

deck = Deck.new
puts deck.deck[0]
deck.shuffle
puts deck.deck[0]
