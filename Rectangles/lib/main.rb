$: << "."
require 'input_parser'
require 'calculator'

include Rectangles

input_parser = InputParser.new
r1,r2 = input_parser.scan


result = Calculator.union(r1, r2)
if (result == -1)
  puts "Ctverce se ani nedotykaji."
elsif (result == 0)
  puts "Ctverce se pouze dotykaji"
else
  puts "Obsah sjednoceni dvou ctvercu je #{result}"
end