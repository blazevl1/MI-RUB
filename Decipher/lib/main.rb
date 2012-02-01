$: << "."
require 'decipher.rb'

if (ARGV.length != 1)
  puts "Musite zadat soubor pro desifrovani jako parametr"
  puts "Napriklad: main.rb input.txt"
end

decipher = Decipher.new
begin
  puts decipher.decipher_file(ARGV[0])
rescue
  puts "Zadany soubor #{ARGV[0]} neexistuje"
end
