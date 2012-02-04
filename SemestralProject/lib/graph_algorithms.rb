require 'thread'
require 'b_f_s_algorithm'
require 'cycle_finding_algorithm'
require 'dijkstra_algorithm'

# Modul obsahuje různé algoritmy pro řešení problémů v grafu (prohledávání do šířky, nalezení nejkratších cest atd.).
# Zároveň poskytuje sadu metod, které tvoří fasádu pro práci s danými algoritmy.

module GraphAlgorithms

  @@algorithms = Hash.new

  # Provede algoritmus BFS na zadaném grafu
  # * root_node_index - id uzlu, ze kterého prohledávání začíná
  # * graph - graf, na kterém se algoritmus provádí
  def bfs(root_node_index,graph)
    algorithm = get_algorithm("BFS")
    return algorithm.execute(root_node_index, graph)
  end

  # Je zadaný graf silně souvislý?
  def is_strongly_connected?(graph)
    nodes = GraphAlgorithms.bfs(0,graph)
    if (nodes.length != graph.number_of_nodes)    
      return false
    end
    inverted_graph = graph.create_inverted
    nodes = GraphAlgorithms.bfs(0,inverted_graph)
    if (nodes.length != inverted_graph.number_of_nodes)   
      return false
    end
    return true
  end

  # Je zadaný graf Eulerovým grafem?
  def is_euler?(graph)
    graph.nodes.each_value() { |node|
      if (node.input_degree != node.output_degree)
        return false
      end
    }
    return true
  end

  # Najde procházku v Eulerově grafu
  # * start_node - uzel, ve kterém procházka začíná
  # * graph - graf na kterém, se algoritmus provádí
  def find_tour_in_euler_graph(start_node,graph)
    algorithm = get_algorithm("CycleFindingAlgorithm")
    return algorithm.execute(start_node,graph)
  end

  # Najde procházku v normálním grafu (nemusí být Eulerův)
  # * start_node - uzel, ve kterém procházka začíná
  # * graph - graf na kterém, se algoritmus provádí
  def find_tour_in_normal_graph(start_node,graph)
    algorithm = get_algorithm("HeuristicAlgorithm")
    return algorithm.execute(start_node,graph)
  end

  # Najde nejbližší uzly od zadaného uzlu (implementováno Dijkstrovým algoritmem)
  # * start_node - uzel, od kterého se hledají nejbližší uzly
  # * graph - graf na kterém, se algoritmus provádí
  def find_closest_nodes(start_node,graph)
    algorithm = get_algorithm("DijkstraAlgorithm")
    return algorithm.execute(start_node,graph)
  end

  private

  # Odložená inicializace algoritmů, pokud již existuje objekt pro vykonávání daného algoritmu, tak ho vrátí
  # pokud ještě neexistuje, tak objekt vytvoří uloží do Hash a vrátí.
  # class_name - název třídy, která implementuje algoritmus
  def get_algorithm(class_name)
    if (@@algorithms.has_key?(class_name))
      algorithm = @@algorithms[class_name]
    else
      algorithm = @@algorithms[class_name] = Object.const_get("GraphAlgorithms").const_get(class_name).new
    end
    return algorithm
  end

end
