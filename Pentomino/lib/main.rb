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

include DLXStructure
include StateSpace
include Pentomino

factory = ItemFactory.new
board = Board.new(5,5)
items = Array.new

=begin
for i in 0..4
  items.push(factory.create('i'))
end
=end

=begin
items[0] = factory.create('f')
items[1] = factory.create('i')
items[2] = factory.create('l')
items[3] = factory.create('n')
items[4] = factory.create('p')
items[5] = factory.create('t')
items[6] = factory.create('u')
items[7] = factory.create('v')
items[8] = factory.create('w')
items[9] = factory.create('x')
items[10] = factory.create('y')
items[11] = factory.create('z')
=end
items.push(factory.create('u'))
items.push(factory.create('u'))
items.push(factory.create('x'))
items.push(factory.create('i'))
items.push(factory.create('i'))



items.each { |item|
  board.add_virtual_item(item);
}

algorithm = DLXAlgorithm.new(board)
algorithm.execute



