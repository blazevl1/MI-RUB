module Rectangles

  require 'rectangle'

  class InputParser

    def scan
      rectangle1 = get_rectangle('prvniho')
      rectangle2 = get_rectangle('druheho')
      return rectangle1, rectangle2
    end

    def get_rectangle(rectangle)
      size = get_size(rectangle)
      x = get_position(rectangle)
      y = get_position(rectangle,'y')
      return Rectangle.new(x,y,size)
    end

    def get_size(rectangle)
      size = scan_and_test("Zadejte velikost strany #{rectangle} ctverce: ", Proc.new {|value|  value.to_i > 0})
      return size.to_i
    end

    def get_position(rectangle, coordinates = 'x')
      size = scan_and_test("Zadejte #{coordinates}-ovou souradnici #{rectangle} ctverce: ")
      return size.to_f
    end

    def scan_and_test (message = 'Zadejte hodnotu: ', condition = Proc.new {true})
        value = scan_value(message)
        until (condition.call(value))
          puts "Spatny vstup."
          value = scan_value(message)
        end
        return value
    end


    def scan_value (message)
      print message
      return gets.chop
    end

    private :get_rectangle,:get_size, :get_position,:scan_and_test, :scan_value
    
  end

end
