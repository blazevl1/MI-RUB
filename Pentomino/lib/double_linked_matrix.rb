module DLXStructure

  class DoubleLinkedMatrix

    def initialize
      @root = DoubleLinkedMatrixItem.new(nil,nil,'root')
      @rows_header = Hash.new
      @columns_header = Hash.new
      @last_row_header = @root
      @last_column_header = @root
      @row_header_iterator = @last_row_header
      @column_header_iterator = @last_row_header
      @rows = 0
      @columns = 0
      @cache_info = Hash.new
      @cache_info['rows'] = true
      @cache_info['columns'] = true
    end

    def connect_item(column_id,row_id)
      invalidate_cache()
      if (not @rows_header.key?(row_id))
        @last_row_header = DoubleLinkedMatrixItem.new(nil,@last_row_header.vertical,row_id)
        @rows_header[row_id] = @last_row_header
      end
      if (not @columns_header.key?(column_id))
        @last_column_header = DoubleLinkedMatrixItem.new(@last_column_header.horizontal,nil,[column_id,0])
        @columns_header[column_id] = @last_column_header
      else

      end
      row_item = @rows_header[row_id].horizontal
      column_item = @columns_header[column_id].vertical
      DoubleLinkedMatrixItem.new(row_item.last,column_item.last,[column_id,row_id])
    end

    def disconnect_section(row_id)
      if (@rows_header.key?(row_id))
        invalidate_cache()
        item_header = @rows_header[row_id]
        item_header.disconnect
        item = item_header
        while (item.horizontal.has_next?)
          item = item.horizontal.next
          if (not item.horizontal.is_first?)
            item.disconnect_all_rows_in_column
          end
        end
      end
    end

    def reconnect_section(row_id)
      if (@rows_header.key?(row_id))
        invalidate_cache()
        item_header = @rows_header[row_id]
        item_header.reconnect
        item = item_header
        while (item.horizontal.has_next?)
          item = item.horizontal.next
          if (not item.horizontal.is_first?)
            item.reconnect_all_rows_in_column
          end
        end
      end
    end

    def rows
      if (@cache_info['rows'])
        return @rows
      else
        count = 0
        while(row_header_has_next?)
          count += 1
          row_header_next
        end
        reset_row_header_iterator
        @cache_info['rows'] = true
        @rows = count
        return @rows
      end
    end

    def get_row(row_id)
      array = Array.new
      if (@rows_header.key?(row_id))
        item = @rows_header[row_id]
        while (item.horizontal.has_next?)
          item = item.horizontal.next
          array.push(item.value[0])
        end
        
      else
        raise "Error invalid key. Row ID #{row_id} does not exists."
      end
      return array;
    end

    def columns
      if (@cache_info['columns'])
        return @columns
      else
        count = 0
        while(column_header_has_next?)
          count += 1
          column_header_next
        end
        reset_column_header_iterator
        @cache_info['columns'] = true
        @columns = count
        return @columns
      end
    end

    def invalidate_cache
      @cache_info['rows'] = false
      @cache_info['columns'] = false
    end

    def row_header_has_next?
      return @row_header_iterator.vertical.has_next?
    end

    def row_header_next
      @row_header_iterator = @row_header_iterator.vertical.next
      return @row_header_iterator.value
    end

    def reset_row_header_iterator
      @row_header_iterator = @root
    end

    def column_header_has_next?
      return @column_header_iterator.horizontal.has_next?
    end

    def column_header_next
      @column_header_iterator = @column_header_iterator.horizontal.next
      return @column_header_iterator.value
    end

    def reset_column_header_iterator
      @column_header_iterator = @root
    end

=begin
    def to_s
      array = Array.new(self.rows)
      for i in 0..100
        array[i] = Array.new(self.columns)
        for j in 0..100
          array[i][j] = ' '
        end
      end
      vertical_item = @root
      while (vertical_item.vertical.has_next?)
        vertical_item = vertical_item.vertical.next
        item = vertical_item
        while (item.horizontal.has_next?)
          item = item.horizontal.next
          if (array[item.value[1]-1] == nil)
            puts "#{item.value[1]-1},#{item.value[0]+1}"
          else
            array[item.value[1]-1][item.value[0]+1] = "O"
          end             
        end
      end
      output = "#{self.columns},#{self.rows}"
      array.each { |array2|
        array2.each { |character|
          output += character
        }
        output += "\n"
      }
      return output
    end
=end

  end

end
