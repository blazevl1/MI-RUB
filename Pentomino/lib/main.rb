$: << "."
require 'double_linked_list_item'
require 'double_linked_matrix'
require 'double_linked_matrix_item'
require 'item'
require 'item_factory'
require 'board'
require 'coordinates'

include DLXStructure
include Pentomino

factory = ItemFactory.new
board = Board.new(10,6)
factory.letters.each { |letter|
  array = factory.create_all_possibilities(letter)
  puts "#{letter}: #{array.length}"
}



