require 'thread'
require 'b_f_s_algorithm'
require 'cycle_finding_algorithm'
require 'dijkstra_algorithm'

module GraphAlgorithms

  @algorithms = Hash.new

  def bfs(root_node_index,graph)
    algorithm = get_algorithm("BFS")
    return algorithm.execute(root_node_index, graph)
  end

  def is_strongly_connected?(root_node_index,graph)
    nodes = GraphAlgorithms.bfs(root_node_index,graph)
    if (nodes.length != graph.number_of_nodes)
      return false
    end
    inverted_graph = graph.create_inverted
    nodes = GraphAlgorithms.bfs(root_node_index,inverted_graph)
    if (nodes.length != inverted_graph.number_of_nodes)
      return false
    end
    return true
  end

  def is_euler?(graph)
    graph.nodes.each_value() { |node|
      if (node.input_degree != node.output_degree)
        return false
      end
    }
    return true
  end

  def find_tour_in_euler_graph(start_node,graph)
    algorithm = get_algorithm("CycleFindingAlgorithm")
    return algorithm.execute(start_node,graph)
  end

  def find_closest_nodes(start_node,graph)
    algorithm = get_algorithm("DijkstraAlgorithm")
    return algorithm.execute(start_node,graph)
  end

  def get_algorithm(class_name)
    if (@algorithms.has_key?(class_name))
      algorithm = @algorithms[class_name]
    else
      algorithm = @algorithms[class_name] = Object.const_get("GraphAlgorithms").const_get(class_name).new
    end
    return algorithm
  end

end
