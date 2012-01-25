$: << "."
require 'file_parser'
require 'graph_algorithms'
require 'dijkstra_algorithm'
require 'heuristic_algorithm'

include FileParser
include GraphAlgorithms

parser = DistanceMatrixFileParser.new
begin
  graph = parser.parse_file('matrix.txt')
  algorithm = HeuristicAlgorithm.new
  tour = algorithm.execute(graph.get_node(0),graph)
  puts tour.to_s
  
rescue RuntimeError => error
  puts "Parsing error: #{error}"
end
