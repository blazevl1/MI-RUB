require 'graph'

module GraphAlgorithms

  class DijkstraAlgorithm

    def initialize
    
    end

    def execute(start_node,graph)
      initialize_algorithm(start_node,graph)
      closes_nodes = Array.new
      until(@nodes.empty?)
        @nodes.sort! { |nodeA,nodeB| nodeA.distance <=> nodeB.distance }
        node = @nodes.first()
        @nodes.delete(node)
        relaxation(node)
        closes_nodes.push(node)
        node.close
      end
      finalize_algorithm(graph)
      return closes_nodes
    end

    def initialize_algorithm(start_node,graph)
      @nodes = Array.new
      start_node.distance = 0
      graph.nodes.each_value { |node|
        @nodes.push(node)
      }
    end

    def finalize_algorithm(graph)
      graph.nodes.each_value { |node|
        node.distance = 1/0.0
      }
    end

    def relaxation(node)
      node.output_edges.each_value { |edge|
        descendant = edge.target
        unless (descendant.closed?)
          distance = node.distance + edge.weight
          if (distance < descendant.distance)
            descendant.distance = distance
          end
        end
      }
    end
  end


end
