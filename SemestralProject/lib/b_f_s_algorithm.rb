require 'thread'

module GraphAlgorithms

  # Abstraktní třída pro hledání uzlů v grafu
  class Search

    public

    # Spusti algoritmus pro hledani uzlu, po dokonceni algoritmu nastavi stav vsech uzlu na OPEN
    # * root_node_index - index uzlu, ze kterho zacne hledani
    # * graph - graf na kterém se má algoritmus provést
    def execute(root_node_index,graph)
      root_node = graph.get_node(root_node_index)
      @graph = graph
      nodes = execute_algorithm(root_node)
      @graph.refresh_nodes()
      return nodes;
    end

    protected

    # Spustí algoritmus
    # Metodu je nutné v potomcích překrýt a doplnit její implementaci
    def execute_algorithm
      raise NotImplementedError
    end

  end

  # Třída je implementací algoritmus BFS
  class BFS < Search

    # Spustí algoritmus
    # * root_node - uzel, ze kterého algoritmus začíná
    def execute_algorithm(root_node)
      init()
      @queue.push(root_node)
      root_node.close
      while (not @queue.empty?)
        node = @queue.pop
        search(node)
        @array.push(node)
      end
      return @array
    end

    private

    # Inicializace algoritmus, vytvoření datových struktur
    def init()
      @queue = Queue.new
      @array = Array.new
    end

    # Objeví všechny neuzavřené sousedy uzly
    # * node - uzel, jehož sousedi budou objeveni
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
