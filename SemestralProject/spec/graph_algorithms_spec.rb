# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'graph_algorithms'

include GraphAlgorithms

describe GraphAlgorithms do

  before(:each) do
    @file_parser = DistanceMatrixFileParser.new
  end

  describe "#bfs" do
    it "should discover all nodes if graph is connected" do
      graph = @file_parser.parse_file('spec/strongly_connected.txt')
      GraphAlgorithms.bfs(0, graph).length.should eql 4
    end

    it "should not discover all nodes if graph is not connected" do
      graph = @file_parser.parse_file('spec/correct_matrix.txt')
      GraphAlgorithms.bfs(0, graph).length.should_not eql 4
    end
  end

  describe "#is_strongly_connected?" do
    it "should return true if graph is strongly connected" do
      graph = @file_parser.parse_file('spec/strongly_connected.txt')
      GraphAlgorithms.bfs(0, graph).length.should_not eql true
    end

    it "should return false if graph is not strongly connected" do
      graph = @file_parser.parse_file('spec/not_strongly_connected.txt')
      GraphAlgorithms.is_strongly_connected?(0, graph).should eql false
    end
  end

  describe "#is_euler_graph?" do
    it "should return true if graph is Euler graph" do
      graph = @file_parser.parse_file('spec/euler_graph.txt')
      GraphAlgorithms.is_euler?(graph).should eql true
    end

    it "should return false if graph is not Euler graph" do
      graph = @file_parser.parse_file('spec/euler_graph.txt')
      edge = Edge.new(graph.get_node(0),graph.get_node(2),1)
      graph.add_edge(edge)
      GraphAlgorithms.is_euler?(graph).should eql false
    end
  end

  describe '#find_closest_nodes' do
    it "should return array of nodes order by distance from start_node" do
      graph = @file_parser.parse_file('spec/graph_for_dijkstra.txt')
      path = Array.new
      path.push(graph.get_node(0))
      path.push(graph.get_node(1))
      path.push(graph.get_node(4))
      path.push(graph.get_node(2))
      path.push(graph.get_node(3))
      path.push(graph.get_node(5))
      GraphAlgorithms.find_closest_nodes(graph.get_node(0),graph).should eql path
    end
  end
  
end

