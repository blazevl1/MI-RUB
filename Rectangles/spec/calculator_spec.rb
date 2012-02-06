 
require 'calculator'
require 'rectangle'

module Rectangles

  describe Calculator do

    describe "#union" do
      it "returns -1 for two nonintersecting rectangles" do
        rectangle1 = Rectangle.new(10,10,20)
        rectangle2 = Rectangle.new(50,50,10)
        Calculator::union(rectangle1,rectangle2).should eql -1
      end

      it "returns -1 for two nonintersecting rectangles" do
        rectangle1 = Rectangle.new(-10e20,3e-2 ,5.23)
        rectangle2 = Rectangle.new(+3e100,-1,4.345643225)
        Calculator::union(rectangle1,rectangle2).should eql -1
      end

      it "returns size of bigger segment if one segment is subset of the other one" do
        rectangle1 = Rectangle.new(10,10,50)
        rectangle2 = Rectangle.new(10,15,10)
        Calculator::union(rectangle1,rectangle2).should eql 2500.0
      end

      it "returns size of union of two segments which intersects" do
        rectangle1 = Rectangle.new(0.000,0.000e-3,4.0)
        rectangle2 = Rectangle.new(2,-2e0,2.0e+0)
        Calculator::union(rectangle1,rectangle2).should eql 19.0
      end

      it "returns size of union of two segments which intersects" do
        rectangle1 = Rectangle.new(0.000,0.000e-3,4.0)
        rectangle2 = Rectangle.new(2,-2e0,2.0e+0)
        Calculator::union(rectangle1,rectangle2).should eql 19.0
      end

      
    end
    
  end
end