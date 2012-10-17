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
				color_region(row, col, @map[row][col], {}) unless cell.colored? 
			end
		end
	end

	def color_region(x, y, name, colors_seen)
		# mark as visited
		@map[x][y].visit
		# pick a color that hasn't been seen
		chosen_color = nil

		# iterate over each neighboring cell - Recurse or note color
		each_direction(x, y) do |xp, yp|
			if (@map[xp][yp] == name) && !@map[xp][yp].visited?		# same region
				chosen_color = color_region(xp, yp, name, colors_seen) # recursive call
			elsif @map[xp][yp].colored?		# neighboring cell already colored
				colors_seen[@map[xp][yp].color] = true	
			end
		end

		# set to the color already chosen or to a color not yet seen
		@map[x][y].color = chosen_color || COLORS.select{|color| !colors_seen[color]}[0]
	end

	# Enumerator returning each available direction
	def each_direction(x, y)
		yield x-1, y if x > 0 #up
		yield x, y-1 if y > 0 #left
		yield x, y+1 if y < @map[x].length-1 #right
		yield x+1, y if x < @map.length-1 #down
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
				puts cell + cell.color + (cell.visited? ? "v" : ".") + " "
			end
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
		regions[line_num] = line.chomp.split(//)
	end

	# color map
	mymap = ColoredMap.new(regions)
	mymap.color_map

	# display colored map
	puts mymap.to_color
end
