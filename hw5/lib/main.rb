$: << "."
require 'solver'

include MinimalCoverage

if (ARGV.length != 1)
  puts "Musite zadat soubor jako parametr"
  puts "Napriklad: main.rb input.txt"
else
  if (File.exist?(ARGV[0]))
    solver = Solver.new
    puts solver.solve(ARGV[0])
  else
    puts "Zadany soubor #{ARGV[0]} neexistuje!"
  end
end


