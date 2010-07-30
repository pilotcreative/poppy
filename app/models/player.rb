class Player
  extend ActiveModel::Naming
  delegate :stop, :start, :pause, :paused?, :next, :previous, :current_song, :ping, :to => :mpc
  attr_reader :mpc
  @@instance = nil

  def initialize(host = 'localhost', port = 6600)
    @mpc = Mpc.new(host,port)
    @@instance = self
  end

  def self.instance
    @@instance = new unless @@instance
    @@instance
  end

  def play(song = nil)
    @mpc.play(song)
  end

  def find(type, what = "")
    @mpc.find(type,what).map{|attributes| Song.new(attributes)}
  end

  def songs
    @mpc.listall.map{|attributes| Song.new(attributes)}
  end

end