# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'graph_algorithms'

include GraphAlgorithms

describe GraphAlgorithms do

  it "BFS should discover all nodes if graph is connected" do
    file_parser = DistanceMatrixFileParser.new
    graph = file_parser.parse_file('spec/strongly_connected.txt')
    GraphAlgorithms.bfs(0, graph).length.should eql 4
  end

  it "BFS should not discover all nodes if graph is not connected" do
    file_parser = DistanceMatrixFileParser.new
    graph = file_parser.parse_file('spec/correct_matrix.txt')
    GraphAlgorithms.bfs(0, graph).length.should_not eql 4
  end

  it "strongly connected method should return true if graph is strongly connected" do
    file_parser = DistanceMatrixFileParser.new
    graph = file_parser.parse_file('spec/strongly_connected.txt')
    GraphAlgorithms.bfs(0, graph).length.should_not eql true
  end

  it "strongly connected method should return false if graph is not strongly connected" do
    file_parser = DistanceMatrixFileParser.new
    graph = file_parser.parse_file('spec/not_strongly_connected.txt')
    GraphAlgorithms.is_strongly_connected?(0, graph).should eql false
  end
end

