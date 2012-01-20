require 'graph'

include GraphModule

describe Node do
  before(:each) do
    @node = Node.new(0)
  end

  it "should has id from initialization" do
    id = 5
    node = Node.new(id)
    node.id.should eql id
  end

  it "should be equal to node with same id and same input and output edges" do
    nodeB = Node.new(2)
    tested_node = Node.new(0)
    edge = Edge.new(tested_node,nodeB,1)
    tested_node.add_edge(edge)
    edge = Edge.new(@node,nodeB,1)
    @node.should eql tested_node
  end

  it "should not be equal to node with same id and different input" do
    nodeA = Node.new(1)
    nodeB = Node.new(2)
    tested_node = Node.new(0)
    edge = Edge.new(tested_node,nodeB,1)
    tested_node.add_edge(edge)
    edge = Edge.new(tested_node,nodeA,1)
    tested_node.add_edge(edge)
    edge = Edge.new(@node,nodeB,1)
    @node.should_not eql tested_node
  end

  it "should not be equal to node with same id and different output" do
    nodeA = Node.new(1)
    nodeB = Node.new(2)
    tested_node = Node.new(0)
    edge = Edge.new(nodeB,tested_node,1)
    tested_node.add_edge(edge)
    edge = Edge.new(nodeA,tested_node,1)
    tested_node.add_edge(edge)
    edge = Edge.new(nodeB,@node,1)
    @node.should_not eql tested_node
  end

  it "should raise error if node is not source node or target node of the edge" do
    nodeA = Node.new(1)
    nodeB = Node.new(2)
    edge = Edge.new(nodeA,nodeB,1)
    lambda { @node.add_edge(edge)}.should raise_error
  end

  it "should add edge to input edges if node is target of the edge" do
    nodeA = Node.new(1)
    edge = Edge.new(nodeA,@node,1)
    @node.input_edges.has_value?(edge).should eql true
  end

  it "should add edge to output edges if node is source of the edge" do
    nodeA = Node.new(1)
    edge = Edge.new(@node,nodeA,1)
    @node.output_edges.has_value?(edge).should eql true
  end

  it "should have output degree equal to number of edges which have this node as source" do
    nodeA = Node.new(1)
    nodeB = Node.new(2)
    edge = Edge.new(@node,nodeA,1)
    edge = Edge.new(@node,nodeB,1)    
    @node.output_degree.should eql 2
  end

  it "should have input degree equal to number of edges which have this node as target" do
    nodeA = Node.new(1)
    nodeB = Node.new(2)
    edge = Edge.new(nodeA,@node,1)
    edge = Edge.new(nodeB,@node,1)
    @node.input_degree.should eql 2
  end

end

