module GraphModule

  class Graph

    def initialize
      @nodes = {}
    end

    def add_node(node)
      @nodes[node.id] = node
    end

    def get_node(id)
      if (@nodes.has_key?(id))
        return @nodes[id]
      else
        raise "Cannot retrive node with ID = #{id}. Node does not exist in this graph."
      end
    end

  end

  class Edge

    def initialize(source,target,weight)
      @source = source
      @target = target
      @weight = weight
    end

    attr_reader :source, :target, :weight

  end

  class Node

    def initialize(id)
      @id= id
      @input_edges = {}
      @output_edges = {}
    end

    def add_edge(edge)
      if (edge.source == self)
        @output_edges[edge.target.id] = edge.target
      elsif (edge.target == self)
        @input_edges[edge.source.id] = edge.source
      else
        raise "You are trying to add edge which does not belong to this node."
      end
    end

    attr_reader :id


  end
    
end
