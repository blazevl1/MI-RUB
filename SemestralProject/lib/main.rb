# To change this template, choose Tools | Templates
# and open the template in the editor.

$: << "."
require 'file_parser'

include FileParser

parser = DistanceMatrixFileParser.new
begin
  parser.parse_file('matrix.txt')
rescue RuntimeError => error
  puts "Parsing error: #{error}"
end
