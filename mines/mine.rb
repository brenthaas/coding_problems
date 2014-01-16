class Mine
  def initialize(x, y, radius)
    @x = x
    @y = y
    @radius = radius
  end

  def location
    [@x, @y]
  end

  def affected_mines(mine_list)
    mine_list.select do |mine|
      self.explodes?(mine)
    end
  end

  def explodes?(other_mine)
    (x2, y2) = other_mine.location
    within_blast_radius?(x2, y2)
  end

  def within_blast_radius?(x2, y2)
    ((@x - x2) ** 2  +  (@y - y2) ** 2) <= (@radius ** 2)
  end
end
