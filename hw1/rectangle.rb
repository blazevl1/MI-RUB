module Rectangles

  class Rectangle

    def initialize(x,y,size)
      @x = x
      @y = y
      @size = size
    end
    
    def border_x_start
      return @x-@size/2
    end
    
    def border_x_end
      return @x+@size/2
    end
    
    def border_y_start
      return @y-@size/2
    end
    
    def border_y_end
      return @y+@size/2
    end

    def to_s
      "a = #{size}, [#{x};#{y}]"
    end

    attr_reader :x,:y,:size

  end
end
