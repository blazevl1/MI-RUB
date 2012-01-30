# Modul pro výpočet sjednocení dvou čtverců

module Rectangles

  # Třída se statickou metodou pro výpočet sjednocení dvou čtverců

  class Calculator

    # Spočítá sjednocení dvou čtverců
    # rectangle1 - první čtverec
    # rectangle2 - druhý čtverec
    #
    # vrací:
    # * hodnotu > 0 - pokud existuje nenulový průnik
    # *0 - pokud se čtverce pouze dotýkají
    # *-1 - pokud je průník prázdný
    def Calculator.union(rectangle1, rectangle2)
      intersection = self::intersection(rectangle1, rectangle2)
      if (intersection > 0)
        return rectangle1.volume+rectangle2.volume-intersection
      else
        return intersection
      end
    end

    private

    # Vypočítá průnik dvou čtverců
    # rectangle1 - první čtverec
    # rectangle2 - druhý čtverec
    def Calculator.intersection(rectangle1, rectangle2)
      x_intersection = self::intersection_dimension(rectangle1.border_x_start,rectangle1.border_x_end,rectangle2.border_x_start,rectangle2.border_x_end)
      y_intersection = self::intersection_dimension(rectangle1.border_y_start,rectangle1.border_y_end,rectangle2.border_y_start,rectangle2.border_y_end)
      if (x_intersection < 0 || y_intersection < 0)
        return -1
      else	
        return x_intersection * y_intersection;
      end
    end

    # Vypočítá průnik dvou intervalů
    # a1 - počátek prvního intervalu
    # a2 - konec prvního intervalu
    # b1 - počátek druhého intervalu
    # b2 - konec druhého intervalu
    def Calculator.intersection_dimension(a1,a2,b1,b2)
      intersection = [a2,b2].min - [a1,b1].max
      return intersection.to_f
    end


  end
end
 
