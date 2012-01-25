module GraphAlgorithms

  class CycleFindingAlgorithm
    def initialize
    
    end

    def execute(start_node,graph)
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

    def nodes
      nodes = Array.new
      @cycles[@start_node.id].each { |array|
        array.each() { |node|
          if (@cycles.has_key?(node.id) && node != @start_node)
            @cycles[node.id].each() { |array|
              array.each() { |node|
                nodes.push(node)
              }
            }
          end
          nodes.push(node)
        }
      }
      return nodes
    end

    def to_s
      output = ''
      self.nodes.each { |node|
        output += "#{node} "
      }
      return output
    end
  end
end