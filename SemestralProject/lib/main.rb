# To change this template, choose Tools | Templates
# and open the template in the editor.

$: << "."
require 'file_parser'
require 'graph_algorithms'
require 'dijkstra_algorithm'

include FileParser
include GraphAlgorithms

parser = DistanceMatrixFileParser.new
begin
  graph = parser.parse_file('matrix.txt')
  algorithm = DijkstraAlgorithm.new
  algorithm.execute(graph.get_node(0),graph)
  
rescue RuntimeError => error
  puts "Parsing error: #{error}"
end
