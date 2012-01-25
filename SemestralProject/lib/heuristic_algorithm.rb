require 'graph'

module GraphAlgorithms

  include GraphModule

  class HeuristicAlgorithm
    def initialize
    
    end

    def execute(start_node,graph)
      input_nodes,output_nodes = split_nodes_into_subsets(graph.nodes)
      create_temporary_edges(input_nodes,output_nodes,graph)
      tour = GraphAlgorithms.find_tour_in_euler_graph(start_node,graph)
      return edges_from_nodes_path(tour.nodes)
    end

    private

    def split_nodes_into_subsets(nodes)
      input_nodes = Hash.new
      output_nodes =  Hash.new
      nodes.each_value() { |node|
        if (node.input_degree > node.output_degree)
          input_nodes[node.id] = node
        elsif (node.input_degree < node.output_degree)
          output_nodes[node.id] = node
        end
      }
      return input_nodes,output_nodes
    end

    def create_temporary_edges(input_nodes,output_nodes,graph)
      input_nodes.each_value { |node|
        targets,paths = find_closest_nodes(node,graph)
        targets.each { |target|
          if (output_nodes.key?(target.id))
            edges = edges_from_nodes_and_paths(node,paths,target)
            edge = TemporaryEdge.new(node,target,edges)
            graph.add_edge(edge)
            break         
          end
        }
      }
    end

    def edges_from_nodes_and_paths(start_node,paths,target)
      target_node = target
      edges = Array.new
      while (target_node != start_node)
        edges.push(paths[target_node])
        target_node = paths[target_node].source
      end
      edges.reverse
    end

    def edges_from_nodes_path(path_of_nodes)
      last_node =  nil
      edges = Array.new
      path_of_nodes.each() { |node|
        if (last_node != nil)
          edge = last_node.output_edges[node.id]
          edges.push(edge) 
        end
        last_node = node
      }
      return edges
    end

  end

end
