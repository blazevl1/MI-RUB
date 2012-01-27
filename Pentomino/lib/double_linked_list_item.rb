module DLXStructure

  class DoubleLinkedListItem

    def initialize(item,parent)
      @previous_item = item
      @next_item = nil
      if(@previous_item != nil)
        @previous_item.next_item = self
      end
      @parent = parent
    end
  
    def reconnect
      @previous_item.next_item = self
      @next_item.previous_item = self
    end
  
    def disconnect
      if (@previous_item != nil)
        @previous_item.vertical_next = @next_item
      end
      if (@next_item != nil)
        @next_item.vertical_previous = @previous_item
      end
    end

    def is_first?
      return @previous_item == nil
    end

    def is_last?
      return @next_item == nill
    end

    def last_item
      if (is_last?)
        return self
      else
        @next_item.last_item
      end
    end

    def next
      @next_item.parent
    end

    def previous
      @previous_item.parent
    end

    attr_accessor :previous_item, :next_item


  end

end
