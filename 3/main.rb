# To change this template, choose Tools | Templates
# and open the template in the editor.

=begin
words = Fiber.new do
  File.foreach ("lorem.txt") do |line|
    line.scan(/\w+/) do |word|
      Fiber.yield word.downcase
    end
  end
end

counts = Hash.new(0)
while word = words.resume
  counts[word] += 1
end

counts.keys.sort.each {|k| print "#{k}: #{counts[k]} "}
=end

def fibonacci_fiber(max)

  fibonacci = Fiber.new() do 
    last_number = Array.new(2);
    last_number[0] = 0;
    last_number[1] = 1;
    while(last_number[1] < max)
      temp = last_number[1];
      last_number[1] = last_number[0] + last_number[1];
      last_number[0] = temp;
      Fiber.yield last_number[1];
    end
  end

  while fibonacci_number = fibonacci.resume
    puts "#{fibonacci_number}"
  end

end



=begin
threads = []
4.times do |number|
  threads << Thread.new(number) do |i|
    raise "Ooooh" if i == 2
    print "#{i}\n"
  end
end
=end
require 'thread'

def fibonacci_threads(max)

  queue = Queue.new

  producer = Thread.new(max) do |i|
    last_number = Array.new(2);
    last_number[0] = 0;
    last_number[1] = 1;
    while(last_number[1] < i)
      temp = last_number[1];
      last_number[1] = last_number[0] + last_number[1];
      last_number[0] = temp;
      queue.push(last_number[1]);
    end
  end

  consumer = Thread.new() {
    while (producer.alive? || !queue.empty?)
      puts "#{queue.pop()}";
    end
  }

  producer.join()
  consumer.join()
end

fibonacci_threads(100);
fibonacci_fiber(100);






