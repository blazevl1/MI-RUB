module MinimalCoverage

  require 'test_case'
  require 'segment'

  # Parser souborů obsahujících zadání jednotlivých problémů
  class FileParser

    # Načte zadání problému ze souboru
    # filename - cesta k souboru
    def parse(filename)
      file = File.open(filename)
      return self::parse_string(file)
    end

    # Načte zadání problému z řetězce znaků
    # string - řetězec znaků obsahující zadání problému
    def parse_string(string)
      test_case_number = 0
      test_cases = []
      test_case = nil
      string.each_line() { |line|
        if (string.lineno == 1)
          test_case_number = line.to_i
        else
          case line
          when /^[0-9]+\s+$/
            test_case = TestCase.new(line.to_i)
            test_cases[test_cases.length] = test_case
          when /^0 0\s$/
            test_case_number -= 1
            if (test_case_number == 0)
              return test_cases
            end
          when /(^[-]{0,1}[0-9]+ [-]{0,1}[0-9]+\s)$/
            segment = create_segment_from_line(line,test_case.endpoint)
            test_case.add_segment(segment)
          end
        end
      }
      return test_cases
    end
  
    private

    # Vytvoří Segment z dat vyskytujících se na řádku
    def create_segment_from_line(line,test_case_endpoint)
      chunks = line.split(' ')
      if (chunks.length >= 2)
        return Segment.new(test_case_endpoint,chunks[0].to_i,chunks[1].to_i)
      else
        raise "Invalid file structure"
      end
    end

  end



end
