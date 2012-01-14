# To change this template, choose Tools | Templates
# and open the template in the editor.


module MinimalCoverage
  class Coverage
    def initialize(endpoint)
      @segments = []
      @coverage_length = 0
      @endpoint = endpoint
    end

    def add_segment(segment)
      if (@coverage_length > segment.right)
        raise "Invalid value, coverage_length value should be higher given expected higher then #{@coverage_length}, got #{segment.right}, segment #{segment.to_s}"
      else
        @segments.push(segment)
        @coverage_length = segment.right
      end
      
    end

    def is_coverage_complete?
      return @endpoint <= @coverage_length
    end

    def to_s
      if is_coverage_complete?
        return "#{@segments.length}\n"+@segments.join("\n")+"\n\n"
      else
        return "0\n\n"
      end
    end

    attr_reader :segments, :coverage_length


  end
end
