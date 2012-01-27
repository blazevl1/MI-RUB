module Pentomino

  class Item

    def initialize(letter,reflection,rotation_90,rotation_180)
      @structure = Hash.new
      for i in 0..4
        @structure[i] = Hash.new
        for j in 0..4
          @structure[i][j] = 0
        end
      end
      @width = 0
      @height = 0
      @coordinates = Array.new
      @letter = letter
      @has_reflection = reflection
      @has_rotation_90 = rotation_90
      @has_rotation_180 = rotation_180
    end

    def fill(x,y)
      if (x < 0 || x > 4 || y < 0 || y > 4)
        raise "Invalid index X and Y. Index must be in Integer range <0;4>"
      else
        @structure[x][y] = 1
        @coordinates.push(Coordinates.new(x,y))
      end
      calculate_boundaries
    end

    # Vytvoří nový objekt třídy Item, takový že je otočený o 90° oproti objektu na kterém je metoda vyvolána

    def create_rotated_90_clone()
      clone = Item.new(@letter,@has_reflection,@has_rotation_90,@has_rotation_180)
      @coordinates.each { |item|
        x= item.y
        y = @width - item.x - 1
        clone.fill(x, y)
      }
      return clone
    end

    # Vytvoří nový objekt třídy Item, takový že je reflexivním obrazem objektu na kterém je metoda vyvolána

    def create_reflected_clone()
      clone = Item.new(@letter,@has_reflection,@has_rotation_90,@has_rotation_180)
      @coordinates.each { |item|
        x= @width - item.x - 1
        y = item.y
        clone.fill(x, y)
      }
      return clone
    end

    def calculate_boundaries
      @height = 0
      @width = 0
      @structure.each { |key,hash|
        if(hash.values.reduce(:+) > 0)
          @width += 1
        end
        start = -1
        finish = -1
        hash.each_key { |index|
          if (hash[index] > 0)
            if (start == -1)
              start = index
            end
            finish = index
          end
        }
        if (@height < (finish-start)+1)
          @height = (finish-start)+1
        end

      }
    end

    # Existuje pro tento objekt reflexivní obraz, který je různý?

    def has_reflection?
      @has_reflection
    end

    # Existuje pro tento objekt obraz otočený o 90°, který je různý?

    def has_rotation_90?
      @has_rotation_90
    end

    # Existuje pro tento objekt obraz otočený o 180°, který je různý?

    def has_rotation_180?
      @has_rotation_180
    end

    def to_s
      lines = Hash.new
      @structure.each { |x,hash|
        hash.each { |y,item|
          if (not lines.key?(y))
            lines[y] = ""
          end
          if (item == 1)
            lines[y] +=  "O "
          else
            lines[y] +=  "  "
          end
        }
      }
      lines.values.join("\n")
    end

    attr_reader :coordinates, :letter, :width, :height
    
  end
  
end
