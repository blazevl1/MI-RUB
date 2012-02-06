# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

module MinimalCoverage
  describe Solver do
    before(:each) do
      @solver = Solver.new
    end

    it "solver should have same output from input.txt as is content of output.txt" do
      content = File.open('spec/output.txt', 'r');
      output = ''
      content.each_line() { |line|
        output += line
      }
      coverages =  @solver.solve("spec/input.txt")
      solver_output = coverages.join('')
      solver_output.chop.should eql output
    end

    it "solver should have same output from input_2.txt as is content of output_2.txt" do
      content = File.open('spec/output_2.txt', 'r');
      output = ''
      content.each_line() { |line|
        output += line
      }
      coverages = @solver.solve("spec/input_2.txt")
      solver_output = coverages.join('')
      solver_output.chop.should eql output
    end
  end

end

