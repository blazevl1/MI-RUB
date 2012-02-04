# Modul obsahující třídy, které se vztahují k datové struktuře grafu

module GraphModule

  # Datová struktura graf
  class Graph

    # Pole všech hran v grafu
    attr_reader :edges
    # Hash všech uzlů v grafu
    attr_reader :nodes

    # Konstruktor
    def initialize
      @nodes = Hash.new
      @edges = Array.new
    end

    # Přidá uzel do grafu
    def add_node(node)
      @nodes[node.id] = node
    end

    # Přidá hranu do grafu
    def add_edge(edge)
      @edges.push(edge)
    end

    # Vrátí uzel grafu s daným ID, pokud existuje jinak vyvolá výjimku
    # * id - id uzlu grafu
    def get_node(id)
      if (@nodes.has_key?(id))
        return @nodes[id]
      else
        raise "Cannot retrieve node with ID = #{id}. Node does not exist in this graph."
      end
    end

    # Existuje v grafu uzel s daným id?
    # * id - id hledaného uzlu
    def exists_node_with_id(id)
      return @nodes.key?(id)
    end

    # Vrátí počet uzlů v grafu
    def number_of_nodes
      return @nodes.length
    end

    # Vytvoří graf s inverzní orientací hran
    def create_inverted
      graph = Graph.new
      @nodes.each_value { |node |
        graph.add_node(Node.new(node.id))
      }
      @edges.each {|edge|
        source = graph.get_node(edge.target.id)
        target = graph.get_node(edge.source.id)
        inverted_edge = Edge.new(source,target,edge.weight)
        graph.add_edge(inverted_edge)
      }
      return graph
    end

    # Obnoví všechny uzly v grafu - nastaví jejich stav na OPEN
    def refresh_nodes
      @nodes.each_value { |node |
        node.open
      }
    end

    # Implementace metody eql?
    # Dva grafy jsou ekvivalentní pokud mají stejný počet uzlů a všechny uzly jsou ekvivalentní (ekvivalence uzlu zahrnuje i testovaní hran)
    def eql? (graph)
      if (@nodes.length != graph.nodes.length)
        return false
      end
      @nodes.each { |id,node|
        if (!graph.get_node(id).eql?(node))
          return false
        end
      }
      return true
    end

  end

  # Třída reprezentující hranu datové struktury grafu
  class Edge

    # Zdrojový uzel hrany (uzel, ze kterého hranu vystupuje)
    attr_reader :source
    # Cílový uzel hrany (uzel, do kterého hrana vstupuje)
    attr_reader :target
    # Váha hrany
    attr_reader :weight

    # Konstruktor
    # přidá hranu do vstupní a výstupní množiny hran obou uzlů
    # * source - zdrojový uzel hrany (uzel, ze kterého hranu vystupuje)
    # * target - cílový uzel hrany (uzel, do kterého hrana vstupuje)
    # * weight - váha hrany
    def initialize(source,target,weight)
      @source = source
      @target = target
      @weight = weight
      @source.add_edge(self)
      @target.add_edge(self)
      @temporary = false
    end

    # Je hrana dočasná?
    def temporary?
      return @temporary
    end

    # Implementace metodye eql?
    # hrany jsou ekvivalentní, jestliže se shodují id zdrojových a cílových uzlů a hrana má stejnou váhu
    def eql? (edge)
      return (self.source.id == edge.source.id && self.target.id == edge.target.id && self.weight == edge.weight)
    end

    # Převedení objektu na řetězec
    def to_s
      "#{source.id}--#{weight}--#{target.id}"
    end
  end

  # Třída reprezentující dočasnou hranu datové struktury grafu
  # Dočasná hrana je složena z nedočasných hran
  class TemporaryEdge < Edge

    @edges = Array.new

    # Konstruktor
    # * source - zdrojový uzel hrany (uzel, ze kterého hranu vystupuje)
    # * target - cílový uzel hrany (uzel, do kterého hrana vstupuje)
    # * edges - pole nedočasných hran, ze kterých je dočasná hrana složena
    def initialize(source,target,edges)
      weight = 0
      @edges = edges
      @edges.each { |edge|
        weight += edge.weight
      }
      super(source,target,weight)
      @temporary = true
    end

    # Převedení objektu na řetězec
    def to_s
      @edges.join(', ')
    end

    
  end

  # Třída reprezentující uzel datové struktury grafu
  class Node

    # ID uzlu
    attr_reader :id
    # Množina vstupních hran
    attr_reader :input_edges
    # Množina výstupních hran
    attr_reader :output_edges
    # Vzdálenost od uzlu (používá se pro Dijkstrův algoritmus)
    attr_accessor :distance

    # Konstruktor
    # * id - id uzlu
    # * distance - vzdálenost od uzlu (používá se pro Dijkstrův algoritmus)
    def initialize(id,distance = 1/0.0)
      @id= id
      @input_edges = {}
      @output_edges = {}
      @closed = false
      @distance = distance
    end

    # Přidá hranu k uzlu
    # hranu přidá do množiny vstupních hran nebo do množiny výstupních hran.
    # Zároveň obsahuje kontrolu, jestli opravdu uzlu tato hrana patří pokud ne vyvolá výjimku.
    def add_edge(edge)
      if (edge.source == self)
        @output_edges[edge.target.id] = edge
      elsif (edge.target == self)
        @input_edges[edge.source.id] = edge
      else
        raise "You are trying to add edge which does not belong to this node."
      end
    end

    # Výstupní stupeň uzlu
    def input_degree
      return @input_edges.length
    end

    # Vstupní stupeň uzlu
    def output_degree
      return @output_edges.length
    end

    # Otevře uzel
    def open
      @closed = false
    end

    # Zavře uzel
    def close
      @closed = true
    end

    # Je uzel uzavřený?
    def closed?
      return @closed
    end

    # Je uzel otevřený?
    def opened?
      return !@closed
    end

    # Implementace metody eql?
    # Dva uzly jsou stejné pokud mají stejné ID, velikost množin vstupních a výstupních hran je stejná
    # a jsou shodné i všechny hrany těchto množin
    def eql?(node)
      if (self.id != node.id)
        return false
      end
      if (@input_edges.length != node.input_edges.length)
        return false
      end
      if (@output_edges.length != node.output_edges.length)
        return false
      end
      @input_edges.each { |nodeId,edge|
        if (!node.input_edges[nodeId].eql?(edge))
          return false
        end
      }
      @output_edges.each { |nodeId,edge|
        if (!node.output_edges[nodeId].eql?(edge))
          return false
        end
      }
      return true
    end

    # Převede objekt na řetězec
    def to_s
      return "(#{id})"
    end

  end
    
end
