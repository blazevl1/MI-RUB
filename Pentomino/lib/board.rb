# To change this template, choose Tools | Templates
# and open the template in the editor.

module Pentomino
  class Board

    def initialize(width,height)
      if (width < 5 || height < 5)
        raise "Invalid board dimensions. Board must be at least 5x5!"
      else
        @width = width
        @height = height
      end
      @items = Hash.new
      @structure = Hash.new
      for i in 0..width-1
        @structure[i] = Hash.new
        for j in 0..height-1
          @structure[i][j] = 0
        end
      end   
    end

    def add_item(item,coordinates)
      @items[item] = coordinates
      item.coordinates.each { |coordinate|
        x = coordinates.x + coordinate.x
        y = coordinates.y + coordinate.y
        if (@structure.key?(x) && @structure[x].key?(y))
          @structure[x][y] = item.letter
        end      
      }
    end

    # Převede všechny možné pozice jednoho předmětu do pole obsahující pole
    # čísel

    def calculate_all_positions_of_item(item)
      for x in 0..(@width-item.width)
        for y in 0..(@height-item.height)
           calculate_position_of_item(item,x,y)
        end
      end
    end

    def calculate_position_of_item(item,x,y)
      array = Array.new
      item.coordinates.each { |coordinate|
        array.push(convert_coordinates_to_number(x + coordinate.x,y + coordinate.y))
      }
      return array
    end

    # Převede koordináty na číslo

    def convert_coordinates_to_number(x,y)
      if ((@width-1) < x || (@height-1) < y)
        raise "Invalid coordinates [#{x};#{y}]. Cannot convert because coordinates are bigger than dimension of board."
      else
        return x*@height + y
      end
    end

    # Převede číslo na koordináty

    def convert_number_to_coordinates(number)
      x = number/@height
      y = number%@height
      return x,y
    end


    def to_s
      lines = Hash.new
      @structure.each { |x,hash|
        hash.each { |y,item|
          if (not lines.key?(y))
            lines[y] = "|"
          end
          if (item != 0)
            lines[y] +=  "#{item}|"
          else
            lines[y] +=  " |"
          end
        }
      }
      lines.values.join("\n")
    end
  end
end
