# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

module MinimalCoverage

  describe TestCase do
    before(:each) do
      @test_case = TestCase.new(10)
    end

    it "must contains only segments with non-zero length" do
      @test_case.add_segment(Segment.new(10,-10,0))
      @test_case.add_segment(Segment.new(10,-10,-5))
      @test_case.add_segment(Segment.new(10,0,0))
      @test_case.add_segment(Segment.new(10,5,0))
      @test_case.segments.length.should eql 1
    end
  end

end

