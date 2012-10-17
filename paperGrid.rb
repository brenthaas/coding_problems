require 'matrix'

class Grid
	def initialize(grid_size)
		@grid_size = grid_size
		@grid = Matrix.build(grid_size) { | row, col| [(col + 1) + (row * grid_size)] }
	end

	def r
		raise "Fold with not enough columns" if @grid.column_size <= 1
		middle_column = @grid.column_size/2
		newgrid = Matrix.build(@grid.row_size, middle_column) do |row,col|
			opposite_index = @grid.column_size-col-1		# last index 0 -> 15 1 -> 14 2 -> 13
			@grid[row,opposite_index].reverse + @grid[row,col]
		end
		@grid = newgrid
	end

	def l
		raise "Fold with not enough columns" if @grid.column_size <= 1
		middle_column = @grid.column_size/2
		newgrid = Matrix.build(@grid.row_size, middle_column) do |row,col|
			opposite_index = @grid.column_size-col-1		# last index 0 -> 15 1 -> 14 2 -> 13
			@grid[row,col] + @grid[row,opposite_index].reverse
		end
		@grid = newgrid
	end

	def t
		raise "Fold with not enough rows" if @grid.row_size <= 1
		middle_row = @grid.row_size/2
		newgrid = Matrix.build(middle_row, @grid.column_size) do |row, column|
			opposite_index = @grid.row_size-row-1		# last index 0 -> 15 1 -> 14 2 -> 13
			@grid[row,column] + @grid[opposite_index,column].reverse 
		end
		@grid = newgrid
	end

	def b
		raise "Fold with not enough rows" if @grid.row_size <= 1
		middle_row = @grid.row_size/2
		newgrid = Matrix.build(middle_row, @grid.column_size) do |row, column|
			opposite_index = @grid.row_size-row-1		# last index 0 -> 15 1 -> 14 2 -> 13
			@grid[opposite_index,column].reverse + @grid[row,column] 
		end
		@grid = newgrid
	end

	def stack
		@grid[0,0]
	end
end

g = Grid.new(4)
puts g.r
puts g.l
puts g.t
puts g.b
puts "Answer #{g.stack}"

