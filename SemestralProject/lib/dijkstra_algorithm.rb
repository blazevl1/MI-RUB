require 'graph'

module GraphAlgorithms

  class DijkstraAlgorithm

    def initialize
    
    end

    def execute(start_node,graph)
      initialize_algorithm(start_node,graph)
      closest_nodes = Array.new  
      until(@nodes.empty?)
        @nodes.sort! { |nodeA,nodeB| nodeA.distance <=> nodeB.distance }
        node = @nodes.first()
        @nodes.delete(node)
        relaxation(node)
        closest_nodes.push(node)
        node.close
      end
      finalize_algorithm(graph)
      return closest_nodes,@paths
    end

    def initialize_algorithm(start_node,graph)
      @nodes = Array.new
      @paths = Hash.new
      start_node.distance = 0
      graph.nodes.each_value { |node|
        @nodes.push(node)
      }
    end

    def finalize_algorithm(graph)
      graph.nodes.each_value { |node|
        node.distance = 1/0.0
        node.open
      }
    end

    def relaxation(node)
      node.output_edges.each_value { |edge|
        descendant = edge.target
        unless (descendant.closed?)
          distance = node.distance + edge.weight
          if (distance < descendant.distance)
            @paths[descendant] = edge
            descendant.distance = distance
          end
        end
      }
    end
  end


end
