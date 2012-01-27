module Pentomino
  class Coordinates
    def initialize(x,y)
      @x = x
      @y = y
    end

    attr_reader :x,:y
  end

  def to_s
    "[#{x};#{y}]"
  end
end
