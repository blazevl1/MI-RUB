module MinimalCoverage

  # Třída reprezentující jednu konkrétní instanci problému minimálního pokrytí

  class TestCase

    # Pole segmentů, kterými je možné pokrýt zadaný úsek
    attr_reader :segments
    # Koncový bod M úsek <0;M>, který je nutné pokrýt
    attr_reader :endpoint

    # Konstruktor
    # endpoint - koncový bod M úsek <0;M>, který je nutné pokrýt

    def initialize(endpoint)
      @endpoint = endpoint
      @segments = []
    end

    # Přidá další segment

    def add_segment(segment)
      if (segment.positive_length > 0)
        @segments.push(segment)
      end
    end

    # Smaže segment
    
    def delete_segment(segment)
      @segments.delete(segment)
    end


    # Převedení na řetězec
    
    def to_s
      output = "Endpoint: #{@endpoint} , Segments: "
      @segments.each { |segment|
        output += " "+segment.to_s
      }
      return output
    end

    
  end

end
