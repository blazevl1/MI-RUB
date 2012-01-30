require 'item'

module Pentomino

  # Třída starající se o vytváření objektů Pentomino::Item
  
  class ItemFactory

    # Konstuktor
    def initialize
      @letters = Hash.new
      @letters['f'] = 1
      @letters['i'] = 2
      @letters['l'] = 3
      @letters['n'] = 4
      @letters['p'] = 5
      @letters['t'] = 6
      @letters['u'] = 7
      @letters['v'] = 8
      @letters['w'] = 9
      @letters['x'] = 10
      @letters['y'] = 11
      @letters['z'] = 12
    end
  

  # Vytvoří položku pentomina dle zadaného písmene, pokud existuje jinak vyvolá výjimku
  # letter - písmeno charakterizující danou položku pentomina

  def create(letter)
    downcase_letter = letter.downcase
    if (@letters.key?(downcase_letter))
      self.send("create_#{downcase_letter}")
    else
      raise "Invalid letter. Letter #{downcase_letter} is not registred in list of pentomino items."
    end
  end

  # Vytvoří pole všech možných pozic zadaného prvku
  # prototype - položka pentomina ze které se mají vygenerovat všechny pozice

  def create_all_possibilities(prototype)
    array = Array.new
    item = create(prototype.letter)
    item.number = prototype.number
    array[0] = create_rotated_possibilities(item)
    if (item.has_reflection?)
      reflected_item = item.create_reflected_clone
      array[1] = create_rotated_possibilities(reflected_item)
    end
    return array.flatten
  end

  # Vrátí všechny zaregistrované písmena charackterizující položky pentomina

  def letters
    return @letters.keys
  end

  private

  # Vytvoří pole všech možných pozic vytvořených rotací zadané položky pentomina
  # item - položka pentomina

  def create_rotated_possibilities(item)
    array = Array.new
    array.push(item)
    if (item.has_rotation_90?)
      item = item.create_rotated_90_clone()
      array.push(item)
      if (item.has_rotation_180?)
        item = item.create_rotated_90_clone()
        array.push(item)
        item = item.create_rotated_90_clone()
        array.push(item)
      end
    end
    return array
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "z"

  def create_z()
    item = Item.new('z',true,true,false)
    for i in 0..2
      item.fill(1,i)
    end
    item.fill(0,0)
    item.fill(2,2)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "y"

  def create_y()
    item = Item.new('y',true,true,true)
    for i in 0..3
      item.fill(1,i)
    end
    item.fill(0,1)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "w"

  def create_w()
    item = Item.new('w',false,true,true)
    for i in 0..1
      item.fill(0,i)
    end
    for k in 1..2
      item.fill(1,k)
    end
    item.fill(2,2)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "v"

  def create_v()
    item = Item.new('v',false,true,true)
    for i in 0..2
      item.fill(0,i)
    end
    for k in 1..2
      item.fill(k,2)
    end
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "u"

  def create_u()
    item = Item.new('u',false,true,true)
    for i in 0..2
      item.fill(i,1)
    end
    item.fill(0,0)
    item.fill(2,0)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "t"

  def create_t()
    item = Item.new('t',false,true,true)
    for i in 0..2
      item.fill(i,0)
    end
    for k in 1..2
      item.fill(1,k)
    end
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "p"

  def create_p()
    item = Item.new('p',true,true,true)
    for i in 0..2
      item.fill(0,i)
    end
    for k in 0..1
      item.fill(1,k)
    end
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "n"

  def create_n()
    item = Item.new('n',true,true,true)
    for i in 1..3
      item.fill(0,i)
    end
    item.fill(1,0)
    item.fill(1,1)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "l"

  def create_l()
    item = Item.new('l',true,true,true)
    for i in 0..3
      item.fill(0,i)
    end
    item.fill(1,3)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "i"

  def create_i()
    item = Item.new('i',false,true,false)
    for i in 0..4
      item.fill(0,i)
    end
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "f"

  def create_f()
    item = Item.new('f',true,true,true)
    item.fill(1,0)
    item.fill(2,0)
    item.fill(0,1)
    item.fill(1,1)
    item.fill(1,2)
    return item
  end

  # Vytvoří položku pentomina charakterizovanou písmenem "x"

  def create_x()
    item = Item.new('x',false,false,false)
    item.fill(1,0)
    item.fill(0,1)
    item.fill(1,1)
    item.fill(2,1)
    item.fill(1,2)
    return item
  end

  end
end
