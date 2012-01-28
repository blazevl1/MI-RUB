module DLXStructure

  class DoubleLinkedMatrixItem
  
    def initialize(horizontal_item,vertical_item,value)
      @items = Hash.new
      @items['horizontal'] = DoubleLinkedListItem.new(horizontal_item,self)
      @items['vertical'] = DoubleLinkedListItem.new(vertical_item,self)
      @connected = true
      @value = value
    end

    # Odpojí prvek pokud již nebyl odpojen

    def disconnect
      if(@connected)      
        if (not @items['vertical'].is_first?())
          #puts "Disconnecting item #{value} vertical"
          @items['vertical'].disconnect
        else
          #puts "Disconnecting item #{value} horizontal"
          @items['horizontal'].disconnect
        end
        @connected = false
      end
    end

    # Připojí prvek, pokud byl odpojený

    def reconnect
      if (not @connected)
        if (not @items['vertical'].is_first?())
          @items['vertical'].reconnect
        else
          @items['horizontal'].reconnect
        end
        @connected = true
      end
    end

    # Pošle zprávu pro odpojení všem prvkům ve sloupci kromě prvku na kterém byla metoda vyvolána

    def disconnect_all_rows_in_column
      call_method_on_columns_items(:disconnect_row)
    end


    # Pošle zprávu pro odpojení řádku, na kterém se prvek nachází, pokud není prvek v hlavičce sloupců

    def disconnect_row
      if (not @items['vertical'].is_first?())
        call_method_on_row_items(:disconnect)
      else
        disconnect
      end

    end

    # Pošle zprávu pro připojení všem prvkům ve sloupci kromě prvku na kterém byla metoda vyvolána

    def reconnect_all_rows_in_column
      call_method_on_columns_items(:reconnect_row)
    end

    # Pošle zprávu pro připojení řádku, na kterém se prvek nachází

    def reconnect_row
      call_method_on_row_items(:reconnect)
    end

    # Pošle zprávu všem prvkům v řádků kromě prvku na kterém byla metoda vyvolána
    # method - metoda, která se má zavolat

    def call_method_on_row_items(method)
      call_method_on_items_except_source(method,'horizontal')
    end

    # Pošle zprávu všem prvkům ve sloupci kromě prvku na kterém byla metoda vyvolána
    # method - metoda, která se má zavolat

    def call_method_on_columns_items(method)
      call_method_on_items_except_source(method,'vertical')
    end

    # Zavolání metody na prvku

    def call_method(method)
      method_object = self.method(method)
      method_object.call
    end

    # Zavolá metodu na všech prvcích v daném směru
    # method - metoda, která se má zavolat
    # item - směr šíření (horizontal/vertical)

    def call_method_on_items(method,item)
      call_method(method)
      call_method_on_items_except_source(method,item)
    end

    # Zavolá metodu na všech prvcích v daném směru kromě aktuálního prvku
    # method - metoda, která se má zavolat
    # item - směr šíření (horizontal/vertical)

    def call_method_on_items_except_source(method,item)
      if (not @items[item].is_first?)
        @items[item].previous.call_method_previous(method,item)
      end
      if (not @items[item].is_last?)
        @items[item].next.call_method_next(method,item)
      end
    end

    # Zavolá metodu na prvku a pošle zprávu dál předchozímu prvku
    # pokud je prvek první zastaví posílání zpráv
    # method - metoda, která se má zavolat
    # item - směr šíření (horizontal/vertical)

    def call_method_previous(method,item)
      call_method(method)
      if (not @items[item].is_first?)
        @items[item].previous.call_method_previous(method,item)
      end
    end

    # Zavolá metodu na prvku a pošle zprávu dál nadcházejícímu prvku
    # pokud je prvek poslední zastaví posílání zpráv
    # method - metoda, která se má zavolat
    # item - směr šíření (horizontal/vertical)

    def call_method_next(method,item)
      call_method(method)
      if (not @items[item].is_last?)
        @items[item].next.call_method_next(method,item)
      else
      end
    end

    def vertical
      return @items['vertical']
    end

    def horizontal
      return @items['horizontal']
    end

    attr_reader :value

  end

end
