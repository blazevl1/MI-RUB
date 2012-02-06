module Rectangles

  require 'rectangle'

  # Třída starající se o načtení správných dat ze vstupu

  class InputParser

    # Metoda pro naskenování uživatelského korektního uživatelského vstupu, která vrací dva čtverce

    def scan
      rectangle1 = get_rectangle('prvniho')
      rectangle2 = get_rectangle('druheho')
      return rectangle1, rectangle2
    end

    # Metoda, která požádá uživatele o zadání velikosti desky pentomina.
    # Zadá-li uživatel špatný vstup, je požádán o zadání znovu.
    # rectangle_type - poradi ctverce (prvni nebo druhy)

    def get_rectangle(rectangle_type)
      size = get_size(rectangle_type)
      x = get_position(rectangle_type)
      y = get_position(rectangle_type,'y')
      return Rectangle.new(x,y,size)
    end

    # Metoda, která požádá uživatele o zadání velikosti strany čtverce
    # Zadá-li uživatel špatný vstup, je požádán o zadání znovu.
    # rectangle_type - poradi ctverce (prvni nebo druhy)

    def get_size(rectangle_type)
      size = scan_and_test("Zadejte velikost strany #{rectangle_type} ctverce: ", Proc.new {|value|  value.to_i > 0})
      return size.to_i
    end

    # Metoda, která požádá uživatele o zadání pozice čtverce
    # Zadá-li uživatel špatný vstup, je požádán o zadání znovu.
    # rectangle_type - poradi ctverce (prvni nebo druhy)
    # coordinates - souradnice (x nebo y)

    def get_position(rectangle_type, coordinates = 'x')
      size = scan_and_test("Zadejte #{coordinates}-ovou souradnici #{rectangle_type} ctverce: ")
      return size.to_f
    end

    # Načte data ze vstupu a validuje je oproti zadané podmínce ve formě bloku.
    # Není-li vstup validní zažádá o nové zadání
    def scan_and_test (message = 'Zadejte hodnotu: ', condition = Proc.new {true})
        value = scan_value(message)
        until (condition.call(value))
          puts "Neplatny uzivatelsky vstup. Zadejte prosim data znovu."
          value = scan_value(message)
        end
        return value
    end

    # Vytištění zprávy a načtení hodnoty ze vstupu

    def scan_value (message)
      print message
      return gets.chop
    end

    private :get_rectangle,:get_size, :get_position,:scan_and_test, :scan_value
    
  end

end
