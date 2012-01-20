module GraphModule

  class Graph

    def initialize
      @nodes = {}
      @edges = []
    end

    def add_node(node)
      @nodes[node.id] = node
    end

    def add_edge(edge)
      @edges.push(edge)
    end

    def get_node(id)
      if (@nodes.has_key?(id))
        return @nodes[id]
      else
        raise "Cannot retrieve node with ID = #{id}. Node does not exist in this graph."
      end
    end

    def number_of_nodes
      return @nodes.length
    end

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

    def refresh_nodes
      @nodes.each_value { |node |
        node.open
      }
    end

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

    attr_reader :edges, :nodes


  end

  class Edge

    def initialize(source,target,weight)
      @source = source
      @target = target
      @weight = weight
      @source.add_edge(self)
      @target.add_edge(self)
    end

    def eql? (edge)
      return (self.source.id == edge.source.id && self.target.id == edge.target.id && self.weight == edge.weight)
    end

    def to_s
      "#{source.id}--#{weight}--#{target.id}"
    end

    attr_reader :source, :target, :weight

  end

  class Node

    def initialize(id)
      @id= id
      @input_edges = {}
      @output_edges = {}
      @closed = false
    end

    def add_edge(edge)
      if (edge.source == self)
        @output_edges[edge.target.id] = edge
      elsif (edge.target == self)
        @input_edges[edge.source.id] = edge
      else
        raise "You are trying to add edge which does not belong to this node."
      end
    end

    def input_degree
      return @input_edges.length
    end

    def output_degree
      return @output_edges.length
    end

    def open
      @closed = false
    end

    def close
      @closed = true
    end

    def closed?
      return @closed
    end

    def opened?
      return !@closed
    end

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

    def to_s
      return "(#{id})"
    end

    attr_reader :id, :input_edges, :output_edges


  end
    
end
