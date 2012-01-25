require 'heuristic_algorithm'

include GraphAlgorithms

describe HeuristicAlgorithm do
  before(:each) do
    @heuristic_algorithm = HeuristicAlgorithm.new
    @file_parser = DistanceMatrixFileParser.new
  end

  it "should create temporary edges if exists nodes with higher input degree than output degree" do
    graph = @file_parser.parse_file('spec/matrixA.txt')
    tour = @heuristic_algorithm.execute(graph.get_node(0),graph)
    count_of_temporary_edges = 0;
    tour.each() { |edge|
      if (edge.temporary?)
        count_of_temporary_edges += 1;
      end
    }
    count_of_temporary_edges.should eql 1
  end

  it "should create temporary edges if exists nodes with higher input degree than output degree" do
    graph = @file_parser.parse_file('spec/matrixB.txt')
    tour = @heuristic_algorithm.execute(graph.get_node(0),graph)
    count_of_temporary_edges = 0;
    tour.each() { |edge|
      if (edge.temporary?)
        count_of_temporary_edges += 1;
      end
    }
    count_of_temporary_edges.should eql 2
  end

  it "should not create temporary edges if does not exists nodes with higher input degree than output degree" do
    graph = @file_parser.parse_file('spec/euler_graph.txt')
    tour = @heuristic_algorithm.execute(graph.get_node(0),graph)
    count_of_temporary_edges = 0;
    tour.each() { |edge|
      if (edge.temporary?)
        count_of_temporary_edges += 1;
      end
    }
    count_of_temporary_edges.should eql 0
  end
end

