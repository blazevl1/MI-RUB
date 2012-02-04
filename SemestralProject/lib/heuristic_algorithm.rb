require 'graph'

module GraphAlgorithms

  include GraphModule

  # Třída zodpovědná za nalezení cesty, pokud graf není Eulerovým grafem
  #
  # Postup algoritmu
  # * projde všechny uzly grafu a rozdělí je do tří množin (vstupní stupeň  == výstupní stupeň, vstupní stupeň  > výstupní stupeň, vstupní stupeň < výstupní stupeň)
  # * vytvoří dočasné hrany, které mají jako zdroj uzel množiny s větším vstupním stupněm a jako cíl uzel z množiny s větším výstupním stupněm
  # * po vytvoření dočasných hran, by měl být graf Eulerovým grafem
  # * je spuštěn algoritmus hledání cyklů na grafu

  class HeuristicAlgorithm

    # Provede algoritmus
    # * graph - datová struktura na které se bude algoritmus provádět
    # * start_node - uzel, ze kterého se začíná

    def execute(start_node,graph)
      input_nodes,output_nodes = split_nodes_into_subsets(graph.nodes)
      create_temporary_edges(input_nodes,output_nodes,graph)
      tour = GraphAlgorithms.find_tour_in_euler_graph(start_node,graph)
      return edges_from_nodes_path(tour.nodes)
    end

    private

    # Vytvoří dvě množiny a vloží do nich některé z uzlů
    # množiny: {vstupní stupeň  > výstupní stupeň}, {vstupní stupeň < výstupní stupeň}
    # * nodes - množina uzlů, která bude rozdělena

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

    # Vytvoří dočasné hrany
    # * input_nodes - množina uzlů, které mají vstupní stupeň  větší než výstupní stupeň
    # * output_nodes - množina uzlů, které mají vstupní stupeň menší než výstupní stupeň
    # * graph - datová struktura na které se bude operace přidání dočasných hran provádět
    def create_temporary_edges(input_nodes,output_nodes,graph)
      input_nodes.each_value { |node|
        targets,paths = find_closest_nodes(node,graph)
        until(node.input_degree == node.output_degree)
          targets.each { |target|
            if (output_nodes.key?(target.id))
              edges = edges_from_nodes_and_paths(node,paths,target)
              edge = TemporaryEdge.new(node,target,edges)
              graph.add_edge(edge)
              if (target.input_degree == target.output_degree)
                output_nodes.delete(target.id)
              end
              break
            end
          }
        end
      }
    end

    # Vytvoří pole hran (cestu)
    # postupuje směrem od cíle ke startu
    #
    # * start_node - počáteční uzel cesty
    # * paths - hash mapa, kde je klíčem uzel a hodnotou hrana (výstup Dijkstrova algoritmu)
    # * target - koncový uzel cesty

    def edges_from_nodes_and_paths(start_node,paths,target)
      target_node = target
      edges = Array.new
      while (target_node != start_node)
        edges.push(paths[target_node])
        target_node = paths[target_node].source
      end
      edges.reverse
    end

    # Vytvoří pole hran (sled)
    #
    # * path_of_nodes - seřazené pole uzlů
    #

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
