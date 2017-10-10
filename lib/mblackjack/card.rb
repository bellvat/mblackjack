class Card
  attr_accessor :rank, :suit

  @@suits = ['S','H','D','C']
  @@ranks = ['ace',2,3,4,5,6,7,8,9,10,'J','Q','K']
  @@values = {'ace'=>[1,11],2=>2,3=>3,4=>4,5=>5,6=>6,7=>7,8=>8,9=>9,10=>10,'J'=>10,'Q'=>10,'K'=>10}

  def initialize (rank,suit)
    @rank = rank
    @suit = suit
  end

  def self.suits
    @@suits
  end

  def self.ranks
    @@ranks
  end

  def self.values
    @@values
  end

  def show_suit_rank
    puts "#{rank}#{suit}"
  end


end
