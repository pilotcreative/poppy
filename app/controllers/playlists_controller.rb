class PlaylistsController < ApplicationController

  def show
    @songs = Playlist.current_playlist_songs
  end

  def move_song
    Player.instance.move_song(params[:from], params[:to])
    @songs = Playlist.current_playlist_songs
    render :action => "show"
  end

  def clear
    Playlist.clear!
  end

  def delete_song
    Player.instance.delete_song(params[:song])
    @songs = Playlist.current_playlist_songs
    render :action => "show", :layout=> nil
  end

end