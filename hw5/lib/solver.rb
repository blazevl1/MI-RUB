require 'file_parser'
require 'coverage'

module MinimalCoverage

  class Solver

    def solve(filename)     
      test_cases = FileParser.parse(filename)
      coverages = []
      iterator = 0
      test_cases.each{|test_case|
        iterator += 1
        coverages.push(find_minimal_coverage(test_case))
      }
      return coverages;
    end

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
