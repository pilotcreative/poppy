module PlayersHelper
  def actual_song(song)
    if song[:title].blank? || song[:artist].blank?
      song[:file]
    else
      song[:artist] + ' - ' + song[:title]
    end 
  end
end