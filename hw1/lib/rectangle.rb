module Rectangles

  # Třída reprezentující čtverec v dvourozměrném prostoru

  class Rectangle

    # x-ová souřadnice středu čtverce
    attr_reader :x
    # y-ová souřadnice středu čtverce
    attr_reader :y
    # velikost strany čtverce
    attr_reader :size
    # obsah čtverce
    attr_reader :volume

    # Konstruktor
    # x - x-ová souřadnice středu čtverce
    # y - y-ová souřadnice středu čtverce
    # size - velikost strany čtverce
    def initialize(x,y,size)
      @x = x
      @y = y
      @size = size
      @volume = size*size
    end

    # Začátek čtverce na x-ové ose
    def border_x_start
      return @x-@size/2.0
    end

    # Konec čtverce na x-ové ose
    def border_x_end
      return @x+@size/2.0
    end

    # Začátek čtverce na y-ové ose
    def border_y_start
      return @y-@size/2.0
    end

    # Konec čtverce na y-ové ose
    def border_y_end
      return @y+@size/2.0
    end

    # Převedení objektu na řetězec
    def to_s
      "a = #{size}, [#{x};#{y}]"
    end

  end
end
