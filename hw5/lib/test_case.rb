# To change this template, choose Tools | Templates
# and open the template in the editor.

module MinimalCoverage

  class TestCase

    def initialize(endpoint)
      @endpoint = endpoint
      @segments = []
    end

    def add_segment(segment)
      if (segment.positive_length > 0)
        @segments[@segments.length] = segment
      end
    end

    def delete_segment(segment)
      @segments.delete(segment)
    end


    def to_s
      output = "Endpoint: #{@endpoint} , Segments: "
      @segments.each { |segment|
        output += " "+segment.to_s
      }
      return output
    end

    attr_reader :segments, :endpoint;
  end

end
