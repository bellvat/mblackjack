class Game
  attr_accessor :deck, :dealer, :no_of_players, :player_arr, :hand_arr

  def initialize(player_count=1)
    @deck = Deck.new
    @dealer = Dealer.new
    @no_of_players = 0
    @player_arr = [@player1, @player2, @player3, @player4]
    @hand_arr = [@hand1, @hand2, @hand3, @hand4, @hand5, @hand6]
  end

  private

  def record_no_of_players
    puts "How many players are playing today?"
    @no_of_players = gets.chomp.to_i

    @no_of_players.times do |c|
        @player_arr[c] = Player.new(100)
        @player_arr[c].player_no = (c+1)
    end
  end

  def start
    if no_of_players < 1
      record_no_of_players
    end
    assign_hand_and_bet
    assign_first_two_round_cards
    show_player_cards
    check_for_two_card_blackjack
    show_one_dealer_card
    player_choose_action
    dealer_draws
    compare_with_dealer
    ask_if_play_again
  end

  def ask_if_play_again
    p "Would you like to play again? (y/n)"
    answer = gets.chomp
    if answer == "y"
      reshuffle_cards
      start
    else
      p "Thanks for playing!"
    end
  end

  def deal_cards
    @dealt_cards = deck.deck.sample(1)
  end

  def remove_card_from_deck
    ind = deck.deck.find_index(@dealt_cards)
    deck.deck.delete_at(ind)
  end

  def assign_hand_and_bet
    no_of_players.times do |n|
      puts "Player #{@player_arr[n].player_no}, how many hands would you like to play?"
      h = gets.chomp.to_i
      @player_arr[n].no_of_hands = h
      h.times do |h|
        @hand_arr[h] = Hand.new
        @hand_arr[h].hand_no = (h+1)
        puts "How much would you like to bet for hand #{@hand_arr[h].hand_no}? "
        b = gets.chomp.to_i
        @hand_arr[h].bet = b
        @player_arr[n].hand << hand_arr[h]
      end
    end
  end

  def assign_first_two_round_cards
    assign_card
    assign_card
  end

  def assign_card
    #Assign to players
    no_of_players.times do |n|
      @player_arr[n].no_of_hands.times do |h|
        @player_arr[n].hand[h].cards_in_hand << deal_cards
        remove_card_from_deck
      end
    end

    #Assign to dealer (WILL HAVE TO FLIP ONE CARD)
    dealer.dealer_hand.cards_in_hand << deal_cards
    remove_card_from_deck
  end

  def show_player_cards
    no_of_players.times do |n|
      @player_arr[n].no_of_hands.times do |h|
        puts "Player #{@player_arr[n].player_no}: Hand #{@player_arr[n].hand[h].hand_no} cards: #{@player_arr[n].hand[h].cards_in_hand}."
        @player_arr[n].hand[h].calc_hand_value
      end
    end
  end

  def show_one_dealer_card
    puts "Dealer one card show: #{dealer.dealer_hand.cards_in_hand[0]}"
  end

  def bust? (card_v)
    card_v > 21
  end

  def player_choose_action
    no_of_players.times do |n|
      hands_left = @player_arr[n].hand - @player_arr[n].hand_done
      while hands_left != []
        hands_left.each do |hand|
          hand_finished = 0
          while hand_finished == 0
            puts "Player #{@player_arr[n].player_no}, for hand #{hand.hand_no} cards: #{hand.cards_in_hand}, would you like to stand(s), hit(h), double down(d) or split(sp)?"
            choice = gets.chomp
            hand.choices << choice

            if choice == "h"
              hand.cards_in_hand << deal_cards[0]
              puts "Player cards: #{hand.cards_in_hand}."
              remove_card_from_deck
              hand.calc_hand_value
              if bust? (hand.hand_value)
                puts "Cards: #{hand.cards_in_hand}. Busted!"
                @player_arr[n].hand_done << hand
                hand_finished = 1
              elsif hand.choices[-2] == "d"
                @player_arr[n].hand_done << hand
                hand_finished = 1
              end
            elsif choice == "d"
              new_bet = (hand.bet *= 2)
              puts "New bet is #{new_bet} dollars."
            elsif choice == "sp"
              popped = hand.cards_in_hand.pop
              popped
              hand.calc_hand_value
              new_hand_no = @player_arr[n].no_of_hands + 1
              @hand_arr[new_hand_no] = Hand.new
              @hand_arr[new_hand_no].cards_in_hand << popped
              @hand_arr[new_hand_no].hand_no = new_hand_no
              @hand_arr[new_hand_no].calc_hand_value
              @hand_arr[new_hand_no].bet = hand.bet
              @player_arr[n].hand << @hand_arr[new_hand_no]
              @player_arr[n].no_of_hands += 1
            elsif choice == "s"
              p "Alright, you stand."
              @player_arr[n].hand_done << hand
              hand_finished = 1
            end
            hands_left = @player_arr[n].hand - @player_arr[n].hand_done
          end
        end
      end
    end
  end

  def blackjack(card_value)
    card_value == 21
  end

  def check_for_two_card_blackjack
    no_of_players.times do |n|
      @player_arr[n].no_of_hands.times do |h|
        if @player_arr[n].hand[h].hand_value == 21
          puts "Player #{@player_arr[n].player_no}, you got BLACKJACK for hand #{@player_arr[n].hand[h].hand_no}."
          @player_arr[n].hand_done << @player_arr[n].hand[h]
        end
      end
    end
  end

  def dealer_draws
    dealer.dealer_hand.calc_hand_value
    while dealer.dealer_hand.hand_value < 17
      dealer.dealer_hand.cards_in_hand<<deal_cards[0]
      remove_card_from_deck
      dealer.dealer_hand.calc_hand_value
    end
    puts "Dealer cards: #{dealer.dealer_hand.cards_in_hand}"
  end

  def compare_with_dealer
    no_of_players.times do |n|
      @player_arr[n].no_of_hands.times do |h|
        if dealer.dealer_hand.hand_value > 21
          if @player_arr[n].hand[h].hand_value <= 21
            puts "Player #{@player_arr[n].player_no}, hand #{@player_arr[n].hand[h].hand_no}: #{@player_arr[n].hand[h].cards_in_hand} - WON"
            @player_arr[n].money_left += @player_arr[n].hand[h].bet
          else
            puts "Player #{@player_arr[n].player_no}, hand #{@player_arr[n].hand[h].hand_no}: #{@player_arr[n].hand[h].cards_in_hand} - Also bust."
          end
        elsif dealer.dealer_hand.hand_value <= 21
          if (@player_arr[n].hand[h].hand_value > dealer.dealer_hand.hand_value) && (@player_arr[n].hand[h].hand_value <=21)
            puts "Player #{@player_arr[n].player_no}, hand #{@player_arr[n].hand[h].hand_no}: #{@player_arr[n].hand[h].cards_in_hand} - WON"
            @player_arr[n].money_left += @player_arr[n].hand[h].bet
          elsif (@player_arr[n].hand[h].hand_value == dealer.dealer_hand.hand_value)
            puts "Player #{@player_arr[n].player_no}, hand #{@player_arr[n].hand[h].hand_no}: #{@player_arr[n].hand[h].cards_in_hand} - EVEN"
          else
            puts "Player #{@player_arr[n].player_no}, hand #{@player_arr[n].hand[h].hand_no}: #{@player_arr[n].hand[h].cards_in_hand} - LOST"
            @player_arr[n].money_left -= @player_arr[n].hand[h].bet
          end
        end
      end
    end
    no_of_players.times do |n|
      puts "Player #{@player_arr[n].player_no} your have #{@player_arr[n].money_left} dollars left."
    end
  end

  def reshuffle_cards
    deck.make_deck
    @no_of_players.times do |c|
      @player_arr[c].hand = []
      @player_arr[c].hand_done = []
      @player_arr[c].no_of_hands = 0
    end
    dealer.dealer_hand.cards_in_hand = []
  end
end
