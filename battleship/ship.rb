class Ship
  attr_reader :size

  def initialize(size)
    @size = size
    @hits = 0
  end

  def sunk?
    @hits == @size
  end

  def hit!
    @hits += 1 unless sunk?
  end
end
