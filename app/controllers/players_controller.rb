class PlayersController < ApplicationController
  before_filter :connect_to_mpc
  def index
  end

  def play
    @mpc.play
  end

  def pause
    @mpc.pause
  end

  def previous
    @mpc.previous
    # render :action => "change_track"
  end

  def next
    @mpc.next
  end

  def stop
    @mpc.stop
  end
  
  def volume
    @mpc.setvol(0)
    render :nothing => true
  end

  private
  def connect_to_mpc
    @mpc = Mpc.new('10.0.1.2')
  end
end