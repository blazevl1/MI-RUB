require 'gserver'

class LogServer < GServer
  def initialize(port=10001, *args)
    super(port, *args)
  end

  def serve(io)
    File.open("welcome.txt", "r") { |file|
      lines = file.readlines
      for line in lines
        io.puts(line+"\r\n")
      end
    }
    
  end
end

server = LogServer.new
server.audit
server.start

while ((command = gets.chomp) != "exit")
  
end
puts "Shutting down the server"
server.shutdown

