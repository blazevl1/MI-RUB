$: << "."
require 'file_parser'
require 'graph_algorithms'
require 'dijkstra_algorithm'
require 'heuristic_algorithm'

include FileParser
include GraphAlgorithms

if (ARGV.length != 2)
  puts "Chybny pocet parametru. Parametry musi byt presne dva."
  puts "Prvni parametr - soubor obsahujici matici incidence"
  puts "Druhy parametr - index uzlu ze ktereho zacina algoritmus."
  puts "Priklad:"
  puts "main.rb matrix.txt 0"
  Kernel.exit
end

begin
  parser = DistanceMatrixFileParser.new
  graph = parser.parse_file(ARGV[0])
  start_node_id = ARGV[1].to_i
  if (graph.exists_node_with_id(start_node_id ))
    start_node = graph.get_node(start_node_id)
    puts "Startovni uzel: #{start_node_id}"
  else
    puts "Jako parametr byl zadan uzel s ID = #{start_node_id}. Tento uzel v grafu neexistuje."
    Kernel.exit
  end
  if (is_strongly_connected?(graph))
    if (is_euler?(graph))
      puts "Zadany graf je Euleruv graf."
      puts "Spoustim algoritmus pro nalezeni prochazky."
      puts find_tour_in_euler_graph(start_node,graph).to_s
    else
      puts "Zadany graf neni Euleruv graf."
      puts "Spoustim heuristiku pro nalezeni prochazky."
      puts find_tour_in_normal_graph(start_node,graph).to_s
    end
  else
    puts "Na zadanem grafu nelze provest vypocet, protoze neni silne souvisly (existuji slepe ulicky, ze kterych neni mozne vyjet)."
    Kernel.exit
  end

rescue RuntimeError => error
  puts "Pri nacitani souboru doslo k chybe: #{error}."
end
