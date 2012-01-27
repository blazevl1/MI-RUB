module DLXStructure

class DoubleLinkedMatrix

  def initialize
    @root = DoubleLinkedMatrixItem.new(nil,nil)
    @rows_header = Hash.new
    @columns_header = Hash.new
    @last_row_header = @root
    @last_column_header = @root
  end

  def connect_item(row_id,column_id)
    if (not @rows_header.key?(row_id))
      @last_row_header = DoubleLinkedMatrixItem.new(nil,@last_row_header.vertical)
      @rows_header[row_id] = @last_row_header    
    end
    if (not @columns_header.key?(column_id))
      @last_column_header = DoubleLinkedMatrixItem.new(@last_column_header.horizontal,nil)
      @columns_header[column_id] = @last_column_header
    end
    row_item = @rows_header[row_id].horizontal
    column_item = @columns_header[column_id].vertical
    DoubleLinkedMatrixItem.new(row_item.last,column_item)
  end

  def disconnect_section(row_id)
    if (@rows_header.key?(row_id))
      item_header = @rows_header.key?(row_id)
      item_header.disconnect
      item = item_header.horizontal.next
      until (item.horizontal.is_last?)
        item.disconnect_all_rows_in_column
        item = item.horizontal.next
      end
    end
  end

  def reconnect_section(row_id)
    if (@rows_header.key?(row_id))
      item_header = @rows_header.key?(row_id)
      item_header.reconnect
      item = item_header.horizontal.next
      until (item.horizontal.is_last?)
        item.reconnect_all_rows_in_column
        item = item.horizontal.next
      end
    end
  end

end

end
