class Player
  attr_accessor :hand, :hand_done, :no_of_hands, :player_no, :money_left

  @@instance_collector = []

  def initialize(no_of_hands = 1, money_left)
      @hand = []
      @hand_done = []
      @no_of_hands = 0
      @player_no = player_no
      @money_left = money_left
      @@instance_collector << self
  end

  def self.instance_collector
      @@instance_collector
  end
end
