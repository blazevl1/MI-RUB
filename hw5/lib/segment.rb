module MinimalCoverage

  class Segment


    def initialize(first = 0,second = 0)
      if (first > second)
        @left = second
        @right = first
      else
        @left = first
        @right = second
      end
      if (@right < 0)
        @positive_length = 0
      elsif (@left > 0)
        @positive_length = @right - @left
      else
        @positive_length = @right
      end
    end

    def <=> object
      if (object.positive_length > @positive_length)
        return 1
      elsif (object.positive_length < @positive_length)
        return -1
      else
        return 0
      end
    end

    def to_s
      "#{@left} #{@right}"
    end

    attr_reader :left, :right, :positive_length
    

  end

end
