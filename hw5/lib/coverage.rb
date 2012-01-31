# Modul je zodpovědný za řešení problému minimálního pokrytí

module MinimalCoverage

  # Třída reprezentuje řešení problému
  # Řešení je postupně konstruováno přidáváním jednotlivých segmentů

  class Coverage

    # Segmenty, které jsou součástí řešení minimálního pokrytí
    attr_reader :segments
    # Aktuální maximální dosažená délka pokrytí
    attr_reader :coverage_length

    # Konstruktor
    def initialize(endpoint)
      @segments = []
      @coverage_length = 0
      @endpoint = endpoint
    end

    # Přidá segment mezi řešení problému a nastaví délku dosaženého pokrytí shodnou s koncovým bodem segmentu
    # segment - segment, který je přidán mezi řešení
    def add_segment(segment)
      if (@coverage_length > segment.right)
        raise "Invalid value, coverage_length value should be higher then #{@coverage_length}, got #{segment.right}, segment #{segment.to_s}"
      else
        @segments.push(segment)
        @coverage_length = segment.right
      end
      
    end

    # Je pokrytí segmentu úplné?
    def is_coverage_complete?
      return @endpoint <= @coverage_length
    end

    # Převede objekt na řetězec
    def to_s
      if is_coverage_complete?
        return "#{@segments.length}\n"+@segments.join("\n")+"\n\n"
      else
        return "0\n\n"
      end
    end

  end
end
