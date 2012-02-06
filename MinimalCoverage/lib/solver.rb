require 'file_parser'
require 'coverage'

module MinimalCoverage

  # Řeší problémy minimálního pokrytí zadané v souboru
  class Solver

    @@parser = FileParser.new
    # Vyřeší problém minimálního pokrytí, který je popsán v souboru a vrátí pole objektů typu Coverage, které obsahují řešení instací
    # filename - cesta k souboru, který obsahuje zadání problému
    def solve(filename)
      test_cases = @@parser.parse(filename)
      coverages = []
      iterator = 0
      test_cases.each{|test_case|
        iterator += 1
        coverages.push(find_minimal_coverage(test_case))
      }
      return coverages;
    end

    # Najde minimální pokrytí pro danou instanci problému (test case)
    # test_case - instance problému
    def find_minimal_coverage(test_case)
      segments = test_case.segments.sort { |a, b| a <=> b }
      offset = 0
      coverage = Coverage.new(test_case.endpoint)
      until (offset >= test_case.endpoint || segments.length <= 0)
        segments_count = segments.length
        segments.each { |segment|
          if (segment.left <= offset && segment.right > offset)
            offset = segment.right
            coverage.add_segment(segment)         
            segments.delete(segment)
          end
        }
        if (segments_count == segments.length)
          return coverage
        end
      end
      return coverage
    end

  end
end
