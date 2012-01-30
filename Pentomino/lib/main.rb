$: << "."
require 'item_factory'
require 'board'
require 'd_l_x_algorithm'
require 'input_parser'

include DLXStructure
include StateSpace
include Pentomino

# Nacteni uzivatelskeho vstupu a vytvoreni desky pentomina

input_parser = InputParser.new
width,height = input_parser.get_board_size()
item_letters = input_parser.get_item_letters()
board = Board.new(width,height)

# Vytvoreni prvku pentomina z nactenych dat
factory = ItemFactory.new
items = Array.new
item_letters.each {|letter|
  items.push(factory.create(letter))
}

# Pridani prvku k desce
items.each { |item|
  board.add_virtual_item(item);
}

# Pokud je mozne ulohu resit spust algoritmus

if (board.can_be_full?)
  algorithm = DLXAlgorithm.new
  algorithm.execute(board)
else
  puts "Bohuzel zadany problem nelze resit. Obsah desky je #{board.max_capacity}, ale obsah jednotlivych dilku je #{board.actual_capacity}"
end






