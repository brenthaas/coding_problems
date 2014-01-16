# There are bunch of mines in this field, and you are tasked with
# exploding as many of them as you can.  The only caveats are you can
# only explode one manually.  The mine you manually explode will set
# off a chain reaction.  For any mine that explodes, all mines within
# the blast radius of that mine will be triggered to explode in one
# second.  The mine you manually explode blows up at time 0.
#
# Your Task: Write a program which will read in a mines file and
# output the maximum number of mines you can explode.  Also output
# which mine you need to manually set off to explode this maximum
# number.  Since there may be multiple mines that blow up a maximal
# number of mines you should output all the mines that do that.
#
# We'll provide you with:
#
# Mines File (space separated)
# x y blast_radius
#
# Example:
# 1 2 53
# -32 40 100
# 10 15 25
# -15 -15 200
require_relative './mine'

class MineExploder
  attr_reader :mines

  def initialize(mines=[])
    @mines = mines
  end

  def add_mine(x, y, radius)
    @mines ||= []
    @mines.push Mine.new(x, y, radius)
  end

  def biggest_explosions
    return nil if @mines.empty?
    affected_mines = @mines.map{ |m| m.affected_mines(@mines) }
    counts = affected_mines.map{ |mines| mines.count }
    max_explosions = counts.max
  end
end
