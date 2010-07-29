class Player
  extend ActiveModel::Naming

  delegate :stop, :start, :paused?, :next,:previous,:current_song,:listall, :to => :mpc
  attr_reader :mpc

  def initialize(host='localhost',port=6600)
    @mpc = Mpc.new(host,port)
  end

  def play(song=nil)
    @mpc.play(song)
  end
  
  def find(type,what="")
    @mpc.find(type,what)
  end

end