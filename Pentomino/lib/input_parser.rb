module Pentomino


  class InputParser

    def get_item_letters()
      size = scan_and_test("Zadejte polozky oddelene carkou (f,i,l,n,p,t,u,v,w,x,y,z): ",
        Proc.new {|value|
          value =~ /^([filnptuvwxyz],)*[filnptuvwxyz]$/
        })
      item_letters = size.split(",")
      return item_letters
    end

    def get_board_size()
      size = scan_and_test("Zadejte velikost desky (format MxN, min 5x5): ",
        Proc.new {|value| value =~ /^(([5-9])|([1-9][0-9]+))x(([5-9])|([1-9][0-9]+))$/ }
      )
      size = size.split("x")
      return size[0].to_i,size[1].to_i
    end

    private

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


  end

end
