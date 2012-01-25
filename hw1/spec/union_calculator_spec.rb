 
require 'spec_helper'

module Rectangles

  describe UnionCalculator do
    
   
   describe "#intersection" do
      it "returns 0 for two nonintersecting rectangles" do
	rectangle1 = Rectangle.new(10,10,20)
	rectangle2 = Rectangle.new(50,50,10)
	UnionCalculator::intersection(rectangle1,rectangle2).should eql -1
      end
      
      it "returns size of smaller segment if one segment is subset of the other one" do
	rectangle1 = Rectangle.new(10,10,50)
	rectangle2 = Rectangle.new(10,15,10)
	UnionCalculator::intersection(rectangle1,rectangle2).should eql 100
      end
      
      it "returns size of intersection of two segments which intersects" do
	rectangle1 = Rectangle.new(30,30,22)
	rectangle2 = Rectangle.new(10,10,20)
	UnionCalculator::intersection(rectangle1,rectangle2).should eql 1
      end
      
      it "returns 0 if segments are touching each other" do
	rectangle1 = Rectangle.new(0,0,20)
	rectangle2 = Rectangle.new(20,20,20)
	UnionCalculator::intersection(rectangle1,rectangle2).should eql 0
      end

    end
    
  end
end