class TennisScorer

  def initialize()
    @server_score = 0;
    @receiver_score = 0;
    @last_won = '';
  end


  def score_server()  
    if (@server_score >= 30)
      @server_score += 10;
    else
      @server_score += 15;
    end
    if (@server_score > 41)
      @last_won = "Server"
      reset_game();
    end
  end

  def score_receiver()    
    if (@receiver_score >= 30)
      @receiver_score += 10;
    else
      @receiver_score += 15;
    end
    if (@receiver_score > 41)
      @last_won = "Receiver"
      reset_game();
    end
  end

  def reset_game()
    @server_score = 0;
    @receiver_score = 0;
  end

  def score()
    return "#{@server_score}-#{@receiver_score}"
  end

  def message()
    if (@server_score>@receiver_score)
       return "Server is winning!"
    elsif (@receiver_score>@server_score)
       return "Receiver is winning!"
    elsif (@receiver_score == 0 && @server_score == 0)
      return message_new_game();
    elsif (@receiver_score == @server_score && @receiver_score == 40)
       return "Match!"
    elsif (@receiver_score == @server_score && @receiver_score < 40)
       return "Draw"
    end
  end

  def message_new_game()
    if (@last_won == '')
      return "New game"
    elsif (@last_won == 'Receiver')
      return "New game - last game won Receiver"
    elsif (@last_won == 'Server')
      return "New game - last game won Server"
    end
  end
  
end