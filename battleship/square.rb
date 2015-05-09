class Square
  class AlreadyShotError < StandardError; end

  attr_reader :shot, :ship

  def initialize
    @shot = false
  end

  def add_ship(ship)
    @ship = ship
  end

  def empty?
    !@shot && ship.nil?
  end

  def shoot!
    raise AlreadyShotError if @shot
    @shot = true
    if ship
      ship.hit!
      true
    else
      false
    end
  end
end
