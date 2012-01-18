# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'file_parser'
require 'graph'

include GraphModule
include FileParser

describe DistanceMatrixFileParser do
  before(:each) do
    @file_parser = DistanceMatrixFileParser.new
  end

  it "should raise error if input file does not contain matrix of dimension MxM" do
    lambda {@file_parser.parse_file('spec/wrong_matrix1.txt')}.should raise_error
  end

  it "should raise error if input file contains negative integer" do
    lambda {@file_parser.parse_file('spec/wrong_matrix2.txt')}.should raise_error
  end

  it "should raise error if input file contains letters" do
    lambda {@file_parser.parse_file('spec/wrong_matrix3.txt')}.should raise_error
  end

  it "should raise error if input file contains special characters" do
    lambda {@file_parser.parse_file('spec/wrong_matrix4.txt')}.should raise_error
  end

  it "should correctly parse file correct_matrix.txt and return graph" do
    graph = @file_parser.parse_file('spec/correct_matrix.txt')
    test_graph = Graph.new
    nodes = {}
    for i in 0..3 do
      nodes[i] = Node.new(i)
      test_graph.add_node(nodes[i])
    end
    test_graph.add_edge(Edge.new(nodes[0],nodes[2],4))
    test_graph.add_edge(Edge.new(nodes[1],nodes[2],7))
    test_graph.add_edge(Edge.new(nodes[1],nodes[3],5))
    test_graph.add_edge(Edge.new(nodes[2],nodes[3],6))
    test_graph.add_edge(Edge.new(nodes[3],nodes[0],10))
    graph.should eql test_graph
  end
end

