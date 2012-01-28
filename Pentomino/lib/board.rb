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
      @virtual_items = Hash.new
      @structure = Hash.new
      for i in 0..width-1
        @structure[i] = Hash.new
        for j in 0..height-1
          @structure[i][j] = 0
        end
      end
      @length = @width*@height-1
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

    def fill(array,item_number)
      item_number = item_number-@length
      if (@virtual_items.key?(item_number))
        letter = @virtual_items[item_number].letter
        array.each { |number|
        x,y = convert_number_to_coordinates(number)
        @structure[x][y] = letter
      }
      else
        puts "Invalid item number. Not found ##{item_number}"
      end  
    end

    def add_virtual_item(item)
      item.number = @virtual_items.length+1
      @virtual_items[item.number] = item
    end

    # Převede všechny možné pozice jednoho předmětu do pole obsahující pole
    # čísel

    def calculate_all_positions_of_item(item)
      numbers = Array.new
      for x in 0..(@width-item.width)
        for y in 0..(@height-item.height)
           numbers.push(calculate_position_of_item(item,x,y))
        end
      end
      return numbers
    end

    def calculate_position_of_item(item,x,y)
      array = Array.new
      item.coordinates.each { |coordinate|
        array.push(convert_coordinates_to_number(x + coordinate.x,y + coordinate.y))     
      }
      array.push(@length+item.number)
      return array
    end

    # Převede koordináty na číslo

    def convert_coordinates_to_number(x,y)
      if ((@width-1) < x || (@height-1) < y)
        #raise "Invalid coordinates [#{x};#{y}]. Cannot convert because coordinates are bigger than dimension of board."
        puts "Invalid coordinates [#{x};#{y}]. Cannot convert because coordinates are bigger than dimension of board."
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

  attr_reader :width, :height, :virtual_items
end
