class PlaylistsController < ApplicationController

  def show
    @songs = Playlist.current_playlist_songs
  end

  def clear
    Playlist.clear!
  end

  def delete_song
    Player.instance.delete_song(params[:song])
    @songs = Playlist.current_playlist_songs
    render :action => "playlist", :layout=> nil
  end

end