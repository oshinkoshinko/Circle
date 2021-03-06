module Public::EventsHelper

  def how_much_score(event_score)
    if 0.6 <= event_score
      @font = "grin-squint"
      @color = "#ff8c00"
    elsif 0.2 <= event_score
      @font = "grin-beam"
      @color = "#ffd151"
    elsif -0.1 <= event_score
      @font = "smile"
      @color = "#F5CA2D"
    elsif -0.5 <= event_score
      @font = "frown"
      @color = "#9EB2F5"
    else
      @font = "angry"
      @color = "#FC3300"
    end
  end

end
