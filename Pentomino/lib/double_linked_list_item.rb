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
      if (not is_first?)
        @previous_item.next_item = self
      end
      if (not is_last?)
        @next_item.previous_item = self
      end
      
    end
  
    def disconnect
      if (not is_first?)
        @previous_item.next_item = @next_item
      end
      if (not is_last?)
        @next_item.previous_item = @previous_item
      end
    end

    def is_first?
      return @previous_item == nil
    end

    def is_last?
      return @next_item == nil
    end

    def has_next?
      return @next_item != nil
    end

    def last
      if (is_last?)
        return self
      else
        @next_item.last
      end
    end

    def next
      @next_item.parent
    end

    def previous
      @previous_item.parent
    end

    attr_accessor :previous_item, :next_item, :parent


  end

end
