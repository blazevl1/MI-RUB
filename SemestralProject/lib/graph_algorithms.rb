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

  def GraphAlgorithms.is_euler?(graph)
    graph.nodes.each_value() { |node|
      if (node.input_degree != node.output_degree)
        return false
      end
    }
    return true
  end

  def GraphAlgorithms.find_tour_in_euler_graph(start_node,graph)
    edges = graph.edges.dup
    tour = Tour.new(start_node)
    node = start_node
    while (edges.length > 0)
      cycle = Array.new
      cycle = find_tour(node,edges,cycle)
      tour.add_cycle(node, cycle.reverse)
      if (edges[0] != nil)
        node = edges[0].source
      end
    end
    return tour
  end

  def find_tour(start_node,edges,tour)
    edges.each { |edge|
      if (edge.source == start_node)
        edges.delete(edge)
        find_tour(edge.target,edges,tour)
      end
    }
    tour.push(start_node)
    return tour
  end

  private :find_tour

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

  class Tour

    def initialize(start_node)
      @start_node = start_node
      @cycles = Hash.new
    end

    def add_cycle(start_node,nodes)
      if (@cycles[start_node.id] == nil)
        @cycles[start_node.id] = Array.new
      end
      if (start_node != @start_node)
        nodes.pop()
      end  
      @cycles[start_node.id].push(nodes)
    end

    def to_s
      @cycles[@start_node.id].each { |array|
        array.each() { |node|
          if (@cycles.has_key?(node.id) && node != @start_node)
            @cycles[node.id].each() { |array|
              array.each() { |node|
                print "#{node} "
              }
            }
          end
          print "#{node} "
        }
      }
    end
  end

    
end
