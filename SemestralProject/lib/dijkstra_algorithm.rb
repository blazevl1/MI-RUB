require 'graph'

module GraphAlgorithms

  # Třída zodpovědná za provádění Dijkstrova algoritmu
  # pro hledání nejkratších cest z jednoho uzlu do všech ostatních uzlů

  class DijkstraAlgorithm

    # Spustí algoritmus
    # * start_node - uzel, ze kterého začíná Dijkstrův algoritmus
    # * graph - graf na kterém je algoritmus prováděn

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

    private

    # Inicializace algoritmu
    # vytvoření používaných datových struktur
    # * start_node - uzel, ze kterého začíná Dijkstrův algoritmus
    # * graph - graf na kterém je algoritmus prováděn

    def initialize_algorithm(start_node,graph)
      @nodes = Array.new
      @paths = Hash.new
      start_node.distance = 0
      graph.nodes.each_value { |node|
        @nodes.push(node)
      }
    end

    # Vyčištění datové struktury Graph po provedení algoritmu
    # * opět otevře uzly
    # * nastaví vzdálenost na nekonečno
    # graph - graf na kterém je algoritmus prováděn

    def finalize_algorithm(graph)
      graph.nodes.each_value { |node|
        node.distance = 1/0.0
        node.open
      }
    end

    # Relaxace hran
    # relaxuje všechny výstupní hrany uzlu
    # * node - uzel, jehož hrany jsou relaxovány

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
