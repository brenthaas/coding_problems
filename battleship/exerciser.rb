require_relative './board'
require_relative './ship'

board = Board.new
ship = Ship.new(2)
board.place_ship(ship: ship, x: 0, y: 0, direction: :vertical)
board.place_ship(ship: ship, x: 1, y: 0, direction: :vertical)
puts board.fire!(x: 0, y: 0)
puts board.fire!(x: 0, y: 1)
