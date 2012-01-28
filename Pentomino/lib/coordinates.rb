module Pentomino

  class Coordinates
    def initialize(x,y)
      @x = x
      @y = y
    end

    def to_s
      "[#{@x};#{@y}]"
    end

    attr_reader :x,:y
  end
  
end
