require 'graph'

include GraphModule

describe Edge do

  it "should be equal to edge with equal nodes and same weight" do
    nodeA = Node.new(0)
    nodeB = Node.new(1)
    edgeA = Edge.new(nodeA,nodeB,10)
    edgeB = Edge.new(nodeA,nodeB,10)
    edgeA.should eql edgeB
  end

  it "should not be equal to edge with equal nodes and different weight" do
    nodeA = Node.new(0)
    nodeB = Node.new(1)
    edgeA = Edge.new(nodeA,nodeB,10)
    edgeB = Edge.new(nodeA,nodeB,15)
    edgeA.should_not eql edgeB
  end

  it "should not be equal to edge with different nodes and same weight" do
    nodeA = Node.new(0)
    nodeB = Node.new(1)
    nodeC = Node.new(3)
    edgeA = Edge.new(nodeA,nodeB,10)
    edgeB = Edge.new(nodeA,nodeC,10)
    edgeA.should_not eql edgeB
  end

  it "should not be equal to edge with inverted edge with same weight" do
    nodeA = Node.new(0)
    nodeB = Node.new(1)
    edgeA = Edge.new(nodeA,nodeB,10)
    edgeB = Edge.new(nodeB,nodeA,10)
    edgeA.should_not eql edgeB
  end
end

