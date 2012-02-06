require 'spec_helper'

module MinimalCoverage

  

  describe FileParser do

    before(:each) do
      @file_parser = FileParser.new
    end

    it "raise error if input has invalid structure" do
      lambda {@file_parser.parse("incorrect_input.txt")}.should raise_error
    end

    it "raise error if input has invalid structure" do
      lambda {@file_parser.parse("incorrect_input1.txt")}.should raise_error
    end
  end

end

