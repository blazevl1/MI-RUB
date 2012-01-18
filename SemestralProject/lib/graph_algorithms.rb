# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'thread'

module GraphAlgorithms

  def GraphAlgorithms.bfs(root_node_index,graph)
    bfs = BFS.new
    return bfs.execute(root_node_index, graph)
  end

  def GraphAlgorithms.is_strongly_connected?(root_node_index,graph)
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

  def GraphAlgorithms.find_tour_in_euler_graph(start_node,graph)
    edges = graph.edges.dup
    return find_tour(start_node,edges,Array.new)
  end

  def find_tour(start_node,edges,tour)
    edges.each { |edge|
      if (edge.source == start_node)
        edges.delete(edge)
        find_tour(edge.target,edges,tour)
      end
    }
    tour.push(start_node)
  end


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
      @queue = Array.new
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
