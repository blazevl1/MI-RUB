# Třída zodpovědná za dešifrování obsahu souboru

class Decipher


  # Dešifruje obsah souboru
  # filename - cesta k souboru, který se má dešifrovat
  def decipher_file(filename)
    if (File.exist?(filename))
      file = File.open(filename)
      return decipher_string(file)
    else
      raise "File does not exists."
    end
  end

  # Dešifruje textový řetězec
  # string - řetězec, který se má dešifrovat
  def decipher_string(string)
    text = ''
    string.each_line() { |line|
      text += decipher_line(line.chop)+"\n"
    }
    return text
  end

  # Dešifruje jeden řádek textového řetězce
  # line - řetězec, který se má dešifrovat
  def decipher_line(line)
    offset = find_offset(line)
    decoded_line = Array.new
    line.each_byte { |byte|
      decoded_byte = byte-offset
      decoded_line.push(decoded_byte)
    }
    return decoded_line.pack('c*').force_encoding('UTF-8')
  end

  # Nalezne hodnotu posunutí v textovém řetězci.
  # Hledání posunutí je triviální analýza řetězce a hledání nejčastějšího znaku, což by měla být mezera.
  # Nebude fungovat na všechny šifry, bylo by potřeba implementovat mnohem propracovanější analýzu.
  # string - řetězec na kterém se hledá hodnota posunutí
  def find_offset(string)
    hash = Hash.new
    string.each_byte { |byte|
      if (hash.key?(byte))
        hash[byte] += 1
      else
        hash[byte] = 1
      end
    }
    the_most_common = hash.max_by {|k,v| v}
    ascii_space = 32
    return the_most_common[0] - ascii_space
  end


end
