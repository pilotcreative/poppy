class PlaylistsController < ApplicationController

  def show
    @songs = Playlist.current_playlist_songs
  end

  def move_song
    @player.move_song(params[:from], params[:to])
    @songs = Playlist.current_playlist_songs
    render :action => "show"
  end

  def clear
    Playlist.clear!
  end

  def delete_song
    @songs = Playlist.current_playlist_songs
    @player.delete_song(params[:song])
    render :action => "show", :layout=> nil
  end

end