require 'thread'

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
      print "#{queue.pop()}\n";
    end
  }

  producer.join()
  consumer.join()
end

fibonacci_threads(100);
fibonacci_fiber(100);






