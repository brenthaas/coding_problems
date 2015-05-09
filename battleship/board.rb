require_relative './square'

class Board
  class LocationError < RuntimeError; end
  class ShipPlacementError < RuntimeError; end

  attr_reader :squares, :width, :height

  def initialize(width=10, height=10)
    @ships = []
    @width = width
    @height = height
    @squares = Array.new(height){ Array.new(width) { Square.new } }
  end

  def fire!(x:, y:)
    raise LocationError, "Shot out of bounds" unless (x < @width && y < @height)
    raise LocationError, "Square already shot" if @squares[y][x].shot
    square = @squares[y][x]
    if !square.shot
      if square.shoot!
        if square.ship.sunk?
          if @ships.all?(&:sunk?)
            :win
          else
            :sunk
          end
        else
          :hit
        end
      else
        :miss
      end
    end
  end

  def place_ship(ship:, x:, y:, direction:)
    if @ships.map(&:object_id).include?(ship.object_id)
      raise ShipPlacementError, "Can't place the same ship twice"
    end

    unless valid_ship_location?(x, y, ship.size, direction)
      raise ShipPlacementError, "Ship placement includes  spaces"
    end

    @ships.push ship
    ship.size.times do
      current_square = @squares[y][x]
      current_square.add_ship(ship)
      (x, y) = move(x, y, direction)
    end
  end

  private

  def valid_ship_location?(x, y, size, direction)
    size.times do
      return false unless valid_square?(x, y) && @squares[y][x].empty?
      (x, y) = move(x, y, direction)
    end
    true
  end

  def valid_square?(x, y)
    x < width && y < height
  end

  def move(x, y, direction)
    if direction.to_s == 'vertical'
      y += 1
    else
      x += 1
    end
    [x, y]
  end
end
