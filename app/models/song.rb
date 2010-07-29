class Song
  extend ActiveModel::Naming

  def initialize(player)
    @player = player.mpc
  end

  def find(type,what="")
    @player.find(type,what)
  end

  def all
    @player.listall
  end

  def current
    @player.current_song
  end
end