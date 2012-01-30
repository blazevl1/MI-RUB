module Pentomino

  # Třída reprezentující souřadnice v dvourozměrném prostoru
  class Coordinates

    # x-ová souřadnice
    attr_reader :x
    # y-ová souřadnice
    attr_reader :y

    # Konstruktor
    # x - x-ová souřadnice
    # y - y-ová souřadnice
    def initialize(x,y)
      @x = x
      @y = y
    end

    # Převedení na řetězec

    def to_s
      "[#{@x};#{@y}]"
    end

    
  end

end