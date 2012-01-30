module DLXStructure

  # Třída reprezentující spojový seznam

  class DoubleLinkedListItem

    # Přechozí prvek v seznamu
    attr_accessor :previous_item
    # Další prvek v seznamu
    attr_accessor :next_item
    # Prvek typu DLXStructure::DoubleLinkedMatrixItem pod který tento prvek patří
    attr_accessor :parent

    # Konstruktor
    # item - předchozí prvek typu DoubleLinkedListItem
    # parent - prvek typu DoubleLinkedMatrixItem pod který tento prvek patří

    def initialize(item,parent)
      @previous_item = item
      @next_item = nil
      if(@previous_item != nil)
        @previous_item.next_item = self
      end
      @parent = parent
    end

    # Znovu připojí položku na původní místo v seznamu
  
    def reconnect
      if (not is_first?)
        @previous_item.next_item = self
      end
      if (not is_last?)
        @next_item.previous_item = self
      end
      
    end

    # Odpojí položku ze seznamu
  
    def disconnect
      if (not is_first?)
        @previous_item.next_item = @next_item
      end
      if (not is_last?)
        @next_item.previous_item = @previous_item
      end
    end

    # Je položka první v seznamu?

    def is_first?
      return @previous_item == nil
    end

    # Je položka poslední v seznamu?

    def is_last?
      return @next_item == nil
    end

    # Má položka v seznamu následovníka?

    def has_next?
      return @next_item != nil
    end

    # Vrátí poslední položku v seznamu

    def last
      if (is_last?)
        return self
      else
        @next_item.last
      end
    end

    # Vrátí další prvek DoubleLinkedMatrixItem

    def next
      @next_item.parent
    end

    # Vrátí předchozí prvek DoubleLinkedMatrixItem

    def previous
      @previous_item.parent
    end


  end

end
