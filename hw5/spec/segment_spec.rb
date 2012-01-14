# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'segment'

module MinimalCoverage

  describe Segment do


    it "creates instance of class Segment" do
      segment = Segment.new(0,0)
      segment.should be_instance_of Segment
    end

    it "positive length must be only positive part of segment" do
      segment = Segment.new(-10,10)
      segment.positive_length.should eql 10
      segment = Segment.new(10,-10);
      segment.positive_length.should eql 10
      segment = Segment.new(-10,-1)
      segment.positive_length.should eql 0
      segment = Segment.new(0,0)
      segment.positive_length.should eql 0
      segment = Segment.new(5,10)
      segment.positive_length.should eql 5
    end

    it "segment with bigger positive length must have higher sorting priority then segment with smaller positive length" do
      segment1 = Segment.new(5,10)
      segment2 = Segment.new(3,10)
      compare = segment1 <=> segment2
      compare.should eql 1
    end
  end
end

