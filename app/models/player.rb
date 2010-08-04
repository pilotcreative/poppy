class Player
  extend ActiveModel::Naming
  delegate :stop, :start, :pause, :paused?, :next, :previous, :ping, :add_to_playlist, :playlist_destroy, :clear!, :rename_playlist, :create_playlist, :delete_song, :list_library, :to => :mpc
  attr_reader :mpc
  @@instance = nil

  def initialize(player="default")
    config = YAML.load_file("#{RAILS_ROOT}config/player.yml")
    @mpc = Mpc.new(config[player]["host"], config[player]["port"])
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

  def current_song
    @songs = @mpc.current_song.map{|attributes| Song.new(attributes)}
    @songs.first
  end

  def songs
    @mpc.list_all_songs.map{|attributes| Song.new(attributes)}
  end

  def current_playlist_songs
    @mpc.current_playlist_songs.map{|attributes| Song.new(attributes) }
  end

  def playlist_info
    @mpc.playlist_info.map{|attributes| Song.new(attributes) }
  end

  def list_playlists
    @mpc.list_playlists.map{|key, value| Playlist.new(value, true)}
  end

  def list_playlist_info(name)
    @mpc.list_playlist_info(name).map{|attributes| Song.new(attributes)}
  end
end