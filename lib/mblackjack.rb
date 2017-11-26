require 'mblackjack/version'
require 'mblackjack/deck'
require 'mblackjack/player'
require 'mblackjack/hand'
require 'mblackjack/dealer'
require 'mblackjack/game'

module Mblackjack
  class CLI
    def self.run
      game = Game.new
      game.record_no_of_players
      game.start
    end
  end
end
