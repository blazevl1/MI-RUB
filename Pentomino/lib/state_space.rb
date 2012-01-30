# Modul pro stavový prostor instancí problémů

module StateSpace

  # Třída reprezentujcí graf stavového prostoru

  class Graph

    # Konstruktor
    def initialize
      @root = Node.new(-2)
    end

    # Vrátí kořen grafu

    def root
      return @root
    end

  end

  # Třída reprezentující uzel v grafu

  class Node

    # Potomci uzlu
    attr_reader :childs
    # Hodnota uzlu
    attr_reader :value
    # Předek uzlu
    attr_accessor :parent

    # Konstruktor
    # value - hodnota uzlu
    def initialize(value)
      @parent = nil
      @childs = Hash.new
      @value = value
    end

    # Přidá potomka aktuálnímu uzlu a nastaví potomkovi jako rodiče aktuální uzel
    # node - potomek

    def add_child(node)
      node.parent = self
      @childs[node.value] = node
    end

    # Má aktuální uzel potomka se zadanou hodnotou?
    # value - hodnota, podle které se hledá potomek

    def has_child_with_value?(value)
      return @childs.key?(value)
    end

    # Je aktuální uzel kořenem?

    def is_root?()
      return @parent == nil
    end
   
  end
end
