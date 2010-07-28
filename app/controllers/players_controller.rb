class PlayersController < ApplicationController
  before_filter :connect_to_mpc
  def index
  end

  def play
    @mpc.play(params[:pos])
    if params[:pos]
      render :action => "change_song"
    end
  end

  def pause
    @mpc.pause
  end

  def previous
    @mpc.previous
    render :action => "change_song"
  end

  def next
    @mpc.next
    render :action => "change_song"
  end

  def stop
    @mpc.stop
  end
  
  def volume
    @mpc.setvol(params[:volume].to_i)
    render :nothing => true
  end

  def volume_up
    @mpc.volume_up
    render :nothing => true
  end

  def volume_down
    @mpc.volume_down
    render :nothing => true
  end

  def ping
    @ping = @mpc.ping
  end

  private
  def connect_to_mpc
    @mpc = Mpc.new('10.0.1.2')
  end
end