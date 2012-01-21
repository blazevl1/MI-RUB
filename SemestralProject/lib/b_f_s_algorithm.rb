# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'thread'

module GraphAlgorithms

  class Search
    def initialize

    end

    public

    def execute(root_node_index,graph)
      root_node = graph.get_node(root_node_index)
      @graph = graph
      nodes = execute_algorithm(root_node)
      @graph.refresh_nodes()
      return nodes;
    end

    protected

    def execute_algorithm
      raise NotImplementedError
    end

  end

  class BFS < Search
    @queue
    @array

    def initialize()
      @queue = Queue.new
      @array = Array.new
    end

    def execute_algorithm(rootNode)
      @queue.push(rootNode)
      rootNode.close
      while (not @queue.empty?)
        node = @queue.pop
        search(node)
        @array.push(node)
      end
      return @array
    end

    private

    def search(node)
      node.output_edges.each_value { |edge|
        neighbour = edge.target
        if (neighbour.opened?)
          neighbour.close
          @queue.push(neighbour)
        end
      }
    end
  end
end
