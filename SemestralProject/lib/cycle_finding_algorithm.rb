module GraphAlgorithms

  # Třída implementující CycleFinding algoritmus
  # Algoritmus je upravanou verzí algoritmu, který je popsán na http://www.algoritmy.net/article/33838/Cycle-finding
  # Původní algoritmus pracuje na neorientovaném grafu. Tento upravený algoritmus dokáže zpracovat i orientovaný graf.
  # Algoritmus je použit pro hledání procházky v Eulerově grafu.
  # Upravený algoritmus fungující pro orientované grafy je založen na použití datové struktury Tour.
  # Do ní jsou vkládány všechny nalezené cykly a až při požádání o vypsání uzlů je koretkně převedena na procházku.
  # U Eulerova orientovaného grafu, se může stát, že najdeme několik cyklů, skončíme v počátečním uzlu a už není možné jít dále (výstupní hrany uzlu byly vyčerpány).
  # Proto upravený algoritmus odebere z grafu všechny cykly a vloží je do datové struktury. Ta při interpretaci procházky na každém uzlu zjistí, jestli z ní nevede cyklus.
  # Pokud vede, tak cyklus vypíše a pokračuje dále ve výpisu původního cyklu.

  class CycleFindingAlgorithm

    # Spustí algoritmus a vrátí datovou strukturu Tour
    # * start_node - uzel, ze kterého začíná procházka
    # * graph - graf na kterém je algoritmus prováděn
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

    private

    # Najde cyklus (procházku) začínající v daném uzlu
    # * start_node - uzel ve kterém cyklus začíná
    # * edges - hrany grafu, které jsou k dispozici
    # * tour - pole do kterého jsou postupně vkládány jednotlivé uzly cyklu
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

  end

  # Datová struktura pro reprezentaci procházky v grafu
  class Tour

    # Konstruktor
    # * start_node - uzel, ve kterém procházky začíná
    def initialize(start_node)
      @start_node = start_node
      @cycles = Hash.new
    end

    # Přidá jeden cyklus do procházky
    # * start_node - uzel, ve kterém cyklus začíná
    # * nodes - všechny uzly cyklu
    def add_cycle(start_node,nodes)
      if (@cycles[start_node.id] == nil)
        @cycles[start_node.id] = Array.new
      end
      if (start_node != @start_node)
        nodes.pop()
      end
      @cycles[start_node.id].push(nodes)
    end

    # Vrátí všechny uzly procházky seřazené podle průchodu
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

    # Převede objekt na řetězec
    def to_s
      output = ''
      self.nodes.each { |node|
        output += "#{node} "
      }
      return output
    end
  end
end