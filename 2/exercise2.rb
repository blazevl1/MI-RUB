$: << "."
require 'summable'

class VowelFinder

  include Enumerable
  include Summable

  @text_vowels
  

  def initialize(text)
    @text_vowels = Array.new
    @vowels = ["a","e","i","o","u"]
    text.each_char { |character|
      if (@vowels.include?(character))
        @text_vowels.push(character);
      end
    }
  end


  def each
      @text_vowels.each { |item| yield item }
  end

end

vf = VowelFinder.new("th e q u i c k brown fo x jumped")
puts "#{vf.inject(:+)}"
puts "#{vf.sum}"
