module MinimalCoverage

  # Třída reprezentující segment, kterým má být pokryt zadaný úsek

  class Segment

    # Počáteční bod
    attr_reader :left
    # Koncový bod
    attr_reader :right
    # Délka části segmentu ležící v intervalu <0;M>, kde M je koncový bod části, které má být pokryta
    attr_reader :positive_length

    # Konstruktor
    # Nezáleží na pořadí paremetrů konstruktoru v metodě jsou oba body umístěny, tak aby
    # první bod byl počátečním bodem segmentu (má menší hodnotu) a druhý bod byl koncovým bodem segmentu (má větší hodnotu)
    # first - první bod daného segmentu
    # second - druhý bod daného segmentu
    def initialize(endpoint,first = 0,second = 0)
      if (first > second)
        @left = second
        @right = first
      else
        @left = first
        @right = second
      end
      @endpoint = endpoint
      calculate_positive_length()
    end

    # Metoda pro porovnání dvou segmentů
    # Segmenty se porovnávají na základě velikosti části segmentu, který leží v intervalu <0;M>, kde M je koncový bod části, které má být pokryta
    def <=> object
      if (object.positive_length > @positive_length)
        return 1
      elsif (object.positive_length < @positive_length)
        return -1
      else
        return 0
      end
    end

    # Převedení objektu na řetězec
    
    def to_s
      "#{@left} #{@right}"
    end

    private

    # Spočítá velikosti části segmentu, který leží v intervalu <0;M>, kde M je koncový bod části, které má být pokryta
    def calculate_positive_length()
      if (@right < 0)
        @positive_length = 0
      elsif (@left > @endpoint)
        @positive_length = 0
      elsif (@left >= 0 && @right <= @endpoint)
        @positive_length = @right - @left 
      elsif (@left >= 0 && @right >= @endpoint)
        @positive_length = @endpoint - @left
      elsif (@left <= 0 && @right >= @endpoint)
        @positive_length = @endpoint
      elsif (@left <= 0 && @right <= @endpoint)
        @positive_length = @right
      end
    end

  end

end
