require 'state_space'

include DLXStructure
include StateSpace

class DLXAlgorithm


  def initialize(board)
    @board = board
  end

  def execute
    beginning = Time.now
    puts "Vytvářím datové struktury pro běh algoritmu..."
    init()
    puts "Datové struktury připraveny."
    puts "Spouštím algoritmus."
    puts ""
    begin
      execute_dlx()
      rows = reconstruct_path()
      rows.each { |row_id|
        array = @matrix.get_row(row_id)
        item_number = array.last
        array.delete(item_number)
        position_numbers = array
        @board.fill(position_numbers,item_number)
      }
      time = Time.now - beginning
      puts "Řešení nalezeno za #{time.round(0)} vteřin."
      puts "----------------"
      puts ""
      print_result()
    rescue
      puts "Nepodařilo se najít řešení"
    end 
  end


  def init
    @rows = extract_data_from_items()
    @matrix = create_matrix(@rows)
  end

  def execute_dlx
    @state_space = StateSpace::Graph.new()
    @actual_node = @state_space.root
    while (@matrix.rows != 0 || @matrix.columns != 0)
      progress = false
      @matrix.reset_row_header_iterator
      while(@matrix.row_header_has_next?)
        value = @matrix.row_header_next
        if (not @actual_node.has_child_with_value?(value))
          node = Node.new(value)
          @actual_node.add_child(node)
          @actual_node = node
          @matrix.disconnect_section(@actual_node.value)
          progress = true
          break
        end
      end
      if (not progress)
        can_backtrack = backtrack
        if (not can_backtrack)
          raise "Unable to find solution"
        end
      end
    end
  end

  def extract_data_from_items
    factory = ItemFactory.new
    rows = Array.new
    @board.virtual_items.each_value { |item|
      items = factory.create_all_possibilities(item)
      items.each() { |specific_item|
        rows = rows | @board.calculate_all_positions_of_item(specific_item)
      }
    }
    return rows
  end

  def create_matrix(rows)
    matrix = DoubleLinkedMatrix.new
    iterator = 1
    rows.each { |columns|
      columns.each { |column_index|
        matrix.connect_item(column_index,iterator)
      }      
      iterator += 1
    }
    return matrix
  end

  def create_column_headers(board,matrix)
    for x in 0..board.width-1
      for y in 0..board.height-1
        number = board.convert_coordinates_to_number(x,y)
        matrix.connect_item(number,0)
      end
    end
  end

  def backtrack
    @matrix.reconnect_section(@actual_node.value)
    if (@actual_node.is_root?)
      return false
    else
      @actual_node = @actual_node.parent
      return true
    end
  end

  def reconstruct_path()
    node = @actual_node
    array = Array.new
    until (node.is_root?)
      array.push(node.value)
      node = node.parent
    end
    return array
  end

  def print_result
    puts "#{@board.to_s}"
  end


end
