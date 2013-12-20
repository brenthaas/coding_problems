#!/usr/bin/env ruby

# Given a map (a plane divided into contiguous regions) it is possible 
#  using at most 4 colors to assign each region a color, such that no two 
#  adjacent regions share a color (where adjacent regions are regions with 
#  a common edge of length greater than zero).
#
# Write a program that takes a map and finds such a coloring. As input, 
#  your program should take the name of a file containing a rectangular 
#  array of (alphabetical) ascii characters. A contiguous region in this array 
#  is defined as a group of characters of equal value, where any character in 
#  the group can be reached from any other by moving up, down, left or right 
#  (but not diagonally) within the group. Multiple regions may use the same 
#  character in the input array.
# 
# Your program should write an array of characters to stdout, where every 
#  region has been replaced by 'R', 'G', 'B' or 'Y.'
# 
# For example, given the input
# 
# aaaad 
# babcd 
# bbbcd
# 
# (one) correct output is:
# 
# RRRRY 
# GRGBY 
# GGGBY
require 'ruby-debug'

class String
	def visit
		@visited = true
	end

	def visited?
		@visited == true
	end

	def color
		@color || "_"
	end

	def color=(newcolor)
		@color = (newcolor)
	end

	def colored?
		@color != nil
	end
end

class ColoredMap
	COLORS = %w(R G B Y)

	def initialize(map)
		@map = map
	end

	def color_map
		# go through each square and color the region if not already colored
		@map.each_with_index do |line, row|
			line.each_with_index do |cell, col|
				color_region(row, col) unless cell.colored? 
			end
		end
	end

	def color_region(startx, starty)
		# pick a color that hasn't been seen
		colors_seen = {}
		region = traverse_region(startx,starty) do |x,y|
			debugger if [x, y] == [2, 15]
			each_direction(x,y) do |px,py|
				colors_seen[@map[px][py].color] = true if @map[px][py].colored? && @map[x][y] != @map[px][py]
			end
		end

		# choose a color that has not been seen
		chosen_color = COLORS.select{|color| !colors_seen[color]}[0]
		# and color all squares in the region
		region.each { |x,y| @map[x][y].color = chosen_color }
	end

	# Enumerator which yields each square in the region
	def traverse_region(x, y, &block)
		traversed = [[x,y]]
		@map[x][y].visit
		block.call x, y

		each_direction(x,y) do |newx, newy|
			if @map[x][y] == @map[newx][newy] && !@map[newx][newy].visited?
				traversed += traverse_region(newx,newy,&block) 
			end
		end
		traversed
	end

	# Enumerator returning each available direction
	def each_direction(x, y)
		yield x-1, y if x > 0 #up
		yield x, y-1 if y > 0 #left
		yield x, y+1 if @map[x][y+1] #right
		yield x+1, y if @map[x+1]
	end

	def to_s
		@map.map do |line|
			line.join + "\n"
		end.join
	end

	def to_color
		@map.map do |line|
			line.map { |cell| cell.color }.join << "\n"
		end.join
	end

	def to_debug
		@map.map do |line|
			line.map do |cell|
				(cell.colored? ? cell.color : cell) + (cell.visited? ? "." : "_") 
			end << "\n"
		end.join
	end
end

if __FILE__ == $PROGRAM_NAME

	abort "NO ARGUMENTS GIVEN - map file must be provided" unless ARGV[0]

	begin
		mapfile = File.new(ARGV[0])
	rescue
		abort "Unable to open file '#{ARGV[0]}'"
	end

	# read in map file
	regions = []
	mapfile.each_with_index do |line, line_num|
		regions[line_num] = line.strip.split(//)
	end

	# color map
	mymap = ColoredMap.new(regions)
	mymap.color_map

	# display colored map
	puts mymap.to_color
end
