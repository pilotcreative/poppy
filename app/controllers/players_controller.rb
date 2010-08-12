class PlayersController < ApplicationController
  def index
    @current_song = Song.current
  end

  def library
    @library = @player.list_library
    render :layout => nil
  end

  def play
    @player.play(params[:song])
    render :nothing => true
  end

  def pause
    @player.pause
    render :nothing => true
  end

  def previous
    @player.previous
    render :action => "change_song"
  end

  def next
    @player.next
    render :action => "change_song"
  end

  def stop
    @player.stop
  end

  def volume
    @player.setvol(params[:volume].to_i)
    render :nothing => true
  end

  def volume_up
    @player.volume_up
    render :nothing => true
  end

  def volume_down
    @player.volume_down
    render :nothing => true
  end

  def ping
    @ping = @player.ping
  end

  def seek
    @player.seek(params[:time].to_i, params[:song])
  end

  def add
    @player.add_to_playlist(params[:uri])
    @songs = Playlist.current.songs
  end
end