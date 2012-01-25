module Rectangles
  class UnionCalculator

    def UnionCalculator.intersection(rectangle1, rectangle2)
      x_intersection = self::intersection_dimension(rectangle1.border_x_start,rectangle1.border_x_end,rectangle2.border_x_start,rectangle2.border_x_end)  
      y_intersection = self::intersection_dimension(rectangle1.border_y_start,rectangle1.border_y_end,rectangle2.border_y_start,rectangle2.border_y_end)
      if (x_intersection < 0 || y_intersection < 0)
	return -1
      else	
	return x_intersection * y_intersection;
      end
    end
    
    def UnionCalculator.intersection_dimension(a1,a2,b1,b2)
      intersection = [a2,b2].min - [a1,b1].max
      return intersection
    end


  end
end
 
