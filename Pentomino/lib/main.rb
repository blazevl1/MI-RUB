$: << "."
require 'double_linked_list_item'
require 'double_linked_matrix'
require 'double_linked_matrix_item'
require 'item'
require 'item_factory'
require 'board'
require 'coordinates'
require 'd_l_x_algorithm'
require 'state_space'
require 'input_parser'

include DLXStructure
include StateSpace
include Pentomino

input_parser = InputParser.new
width,height = input_parser.get_board_size()
item_letters = input_parser.get_item_letters()
board = Board.new(width,height)

factory = ItemFactory.new
items = Array.new
item_letters.each {|letter|
  items.push(factory.create(letter))
}
items.each { |item|
  board.add_virtual_item(item);
}

if (board.can_be_full?)
  algorithm = DLXAlgorithm.new(board)
  algorithm.execute
else
  puts "Bohuzel zadany problem nelze resit. Obsah desky je #{board.max_capacity}, ale obsah jednotlivych dilku je #{board.actual_capacity}"
end






