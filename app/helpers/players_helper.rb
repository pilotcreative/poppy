module PlayersHelper
  def song_info(song)
    if song[:title].blank? || song[:artist].blank?
      song[:file]
    else
      song[:artist] + ' - ' + song[:title]
    end 
  end

  def extended_song_info(song)
    output = ''
    if song.include?(:album)
      output = content_tag(:strong,'Album:') + song[:album]
    end
    if song.include?(:genre)
      output += content_tag(:strong,' Genre:') + song[:genre]
    end
    if song.include?(:date)
      output += content_tag(:strong,' Date:')  + song[:date]
    end
    output
  end
end