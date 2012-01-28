module StateSpace

  class Graph
    def initialize
      @root = Node.new(-2)
    end

    def root
      return @root
    end

    def print

    end
  end

  class Node
    def initialize(value)
      @parent = nil
      @childs = Hash.new
      @value = value
    end

    def add_child(node)
      node.parent = self
      @childs[node.value] = node
    end

    def has_child_with_value?(value)
      return @childs.key?(value)
    end

    def is_root?()
      return @parent == nil
    end

    def parent=(parent)
      @parent = parent
    end

    def print_subtree
      @childs.each_value { |child|
        print "#{child.value} "
      }
      @childs.each_value { |child|
        puts ""
        child.print_subtree
      }
    end


    attr_reader :childs, :value, :parent
  end
end
