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
  p GraphAlgorithms.bfs(0,graph)
rescue RuntimeError => error
  puts "Parsing error: #{error}"
end
