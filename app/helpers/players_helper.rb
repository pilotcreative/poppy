module PlayersHelper
  def song_info(song)
    if song[:title].blank? || song[:artist].blank?
      song[:file]
    else
      song[:artist] + ' - ' + song[:title]
    end 
  end
end