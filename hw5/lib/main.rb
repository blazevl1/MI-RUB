$: << "."
require 'solver'

include MinimalCoverage


solver = Solver.new
puts solver.solve("input_2.txt")