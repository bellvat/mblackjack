class Deck
    attr_accessor :unique_cards, :cards, :ace

    def initialize
        @unique_cards = ['ace',2,3,4,5,6,7,8,9,10,'J','Q','K']

       @cards = []
       @@card_values = {}

       make_deck
       assign_value
    end

    def make_deck
        @cards = []
        @cards << unique_cards * 4
        @cards = @cards.flatten
    end

    def self.card_values
        @@card_values
    end

    def assign_value
        v = 1
        unique_cards.each do |c|
            @@card_values.store(c, v)
            v += 1
        end
        @@card_values['ace'] = [1,11]
        @@card_values['J'] = 10
        @@card_values['Q'] = 10
        @@card_values['K'] = 10
    end
  end
