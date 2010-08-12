class PlaylistsController < ApplicationController

  def show
    @songs = Playlist.current.songs
    render :layout => nil
  end

  def move_song
    @player.move_song(params[:from], params[:to])
    @songs = Playlist.current_playlist_songs
    render :action => "show", :layout => nil
  end

  def clear
    Playlist.current.clear!
  end

  def delete_song
    @player.delete_song(params[:song])
    @songs = Playlist.current.songs
    render :action => "show", :layout=> nil
  end

end