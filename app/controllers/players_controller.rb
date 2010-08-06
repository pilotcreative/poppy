class PlayersController < ApplicationController
  before_filter :connect_to_player
  def index
    @current_song = Song.current
  end

  def playlist
    @songs = Playlist.current_playlist_songs
  end

  def library
    @library = Player.instance.list_library
  end

  def play
    @player.play(params[:song])
    if params[:song]
      render :action => "change_song"
    end
  end

  def pause
    @player.pause
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

  private

  def connect_to_player
    @player = Player.new("object_reload")
  end
end