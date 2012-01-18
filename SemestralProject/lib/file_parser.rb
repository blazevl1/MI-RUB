require 'graph'

module FileParser

  class DistanceMatrixFileParser

    def parse_file(filename)
      file_content = File.open(filename,'r')
      parse(file_content)
    end

    private

    def parse(content)
      matrix = create_matrix(content)
      graph = create_graph_from_matrix(matrix)
      return graph
    end

    def create_matrix(content)
      matrix = []
      content.each_line() { |line|
        chunks = line.split(/[\s]*/);
        matrix[content.lineno-1] = []
        chunks.each_index() { |index|
          value = chunks[index].strip
          if (/^{0,1}[0-9]+$/ =~ value)
            matrix[content.lineno-1].push(value.to_i)
          else
            raise "Invalid file structure. Expected number given: #{value}"
          end
        }
      }
      check_matrix(matrix)
      return matrix
    end

    def check_matrix(matrix)
      matrix.each_index { |index|
        if (matrix.length != matrix[index].length)
          raise "Invalid matrix dimension. Distance matrix dimension must be MxM! Found dimension #{matrix.length}x#{matrix[index].length} on row #{index}."
        end
      }
    end

    def create_graph_from_matrix(matrix)
      graph = GraphModule::Graph.new
      for id in (0..matrix.length)
        graph.add_node(GraphModule::Node.new(id))
      end
      matrix.each_index { |node_A_index|
        matrix[node_A_index].each_index { |node_B_index|
          weight = matrix[node_A_index][node_B_index]
          if (weight != 0)          
            source_node = graph.get_node(node_A_index)
            target_node = graph.get_node(node_B_index)
            edge = GraphModule::Edge.new(source_node,target_node,weight)
            source_node.add_edge(edge)
            target_node.add_edge(edge)          
          end
        }
      }   
    end
  end
    
end
