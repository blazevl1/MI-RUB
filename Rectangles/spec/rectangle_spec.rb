require 'rectangle'

module Rectangles

  describe Rectangle do
    
    before :each do
      @rectangle = Rectangle.new(1,-0.2,2)
    end
    
    describe "#new" do
      it "returns a new rectangle object" do
        @rectangle.should be_instance_of Rectangle
      end
      
      it "raise error when pass fewer then 2 parameters" do
        lambda { Rectangle.new 1,2}.should raise_exception ArgumentError
      end 
    end
    
    describe "#size" do
      it "return value of size" do
        @rectangle.size.should eql 2
      end
    end
    
    describe "#x" do
      it "return value of x" do
        @rectangle.x.should eql 1
      end
    end
   
    describe "#y" do
      it "return value of y" do
        @rectangle.y.should eql -0.2
      end
    end
   
    describe "#border_x_start" do
      it "return value of rectangle left border coordinate" do
        @rectangle.border_x_start.should eql 0.0
      end
    end
   
    describe "#border_x_end" do
      it "return value of rectangle right border coordinate" do
        @rectangle.border_x_end.should eql 2.0
      end
    end
   
    describe "#border_y_start" do
      it "return value of rectangle top border coordinate" do
        @rectangle.border_y_start.should eql -1.2
      end
    end
   
    describe "#border_y_end" do
      it "return value of rectangle bottom border coordinate" do
        @rectangle.border_y_end.should eql 0.8
      end
    end
    
  end
end
