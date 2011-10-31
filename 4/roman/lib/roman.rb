class Roman
MAX_ROMAN = 4999
  def initialize(value)
      if value <= 0 || value > MAX_ROMAN
          fail "Roman values must be > 0 and <= #{MAX_ROMAN}"
      end
      @value = Integer(value)
  end

  FACTORS = {
    1 => "i",
    4 => "iv",
    5 => "v",
    9 => "ix",
    10 => "x",
    40 => "xl",
    50 => "l",
    90 => "xc",
    100 => "c",
    400 => "cd",
    500 => "d",
    900 => "cm",
    1000 => "m"
  }

  def to_s
    target = @value
    roman = ""
    FACTORS.reverse_each() {| div, value |
      count, target = target.divmod(div)
      roman << value * count;
    }
    roman
  end
end