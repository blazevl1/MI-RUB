module Pentomino
  class ItemFactory
    def initialize
      @letters = Hash.new
      @letters['f'] = true
      @letters['i'] = true
      @letters['l'] = true
      @letters['n'] = true
      @letters['p'] = true
      @letters['t'] = true
      @letters['u'] = true
      @letters['v'] = true
      @letters['w'] = true
      @letters['x'] = true
      @letters['y'] = true
      @letters['z'] = true
    end
  end

  def create(letter)
    downcase_letter = letter.downcase
    if (@letters.key?(downcase_letter) && @letters[downcase_letter])
      self.send("create_#{downcase_letter}")
    end
  end

  def create_all_possibilities(letter)
    array = Array.new
    item = create(letter)
    array[0] = create_rotated_possibilities(letter,item)
    if (item.has_reflection?)
      reflected_item = item.create_reflected_clone
      array[1] = create_rotated_possibilities(letter,reflected_item)
    end
    return array.flatten
  end

  def create_rotated_possibilities(letter,item)
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

  def letters
    return @letters.keys
  end

  def create_z()
    item = Item.new('z',true,true,false)
    for i in 0..2
      item.fill(1,i)
    end
    item.fill(0,0)
    item.fill(2,2)
    return item
  end

  def create_y()
    item = Item.new('y',true,true,true)
    for i in 0..3
      item.fill(1,i)
    end
    item.fill(0,1)
    return item
  end

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

  def create_u()
    item = Item.new('u',false,true,true)
    for i in 0..2
      item.fill(i,1)
    end
    item.fill(0,0)
    item.fill(2,0)
    return item
  end

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

  def create_n()
    item = Item.new('n',true,true,true)
    for i in 1..3
      item.fill(0,i)
    end
    item.fill(1,0)
    item.fill(1,1)
    return item
  end

  def create_l()
    item = Item.new('l',true,true,true)
    for i in 0..3
      item.fill(0,i)
    end
    item.fill(1,3)
    return item
  end

  def create_i()
    item = Item.new('i',false,true,false)
    for i in 0..4
      item.fill(0,i)
    end
    return item
  end

  def create_f()
    item = Item.new('f',true,true,true)
    item.fill(1,0)
    item.fill(2,0)
    item.fill(0,1)
    item.fill(1,1)
    item.fill(1,2)
    return item
  end

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
