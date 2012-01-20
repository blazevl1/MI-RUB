# To change this template, choose Tools | Templates
# and open the template in the editor.

$: << "."
require 'file_parser'
require 'graph_algorithms'

include FileParser
include GraphAlgorithms

parser = DistanceMatrixFileParser.new
begin
  graph = parser.parse_file('matrix.txt')
  tour = GraphAlgorithms.find_tour_in_euler_graph(graph.get_node(0),graph)
  tour.to_s
rescue RuntimeError => error
  puts "Parsing error: #{error}"
end
