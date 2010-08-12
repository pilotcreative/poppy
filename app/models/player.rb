class Player
  extend ActiveModel::Naming
  delegate :stop, :stopped?, :start, :pause, :paused?, :next, :previous, :ping, :add_to_playlist, :playlist_destroy, :clear!, :rename_playlist, :create_playlist, :delete_song, :list_library, :volume, :volume_up, :volume_down, :to => :mpc
  attr_reader :mpc
  @@instance = nil

  def initialize(player = "default")
    config = YAML.load_file(Rails.root.join("config", "player.yml"))
    @mpc = Mpc.new(config[player]["host"], config[player]["port"])
    @@instance = self
  end

  def self.instance
    @@instance ||= new
  end

  def play(song = nil)
    @mpc.play(song)
  end

  def find(type, what = "")
    @mpc.find(type, what).map{|attributes| Song.new(attributes)}
  end

  def current_song
    Song.new(@mpc.current_song) unless @mpc.current_song.nil?
  end

  def songs
    @mpc.list_all_songs.map{|attributes| Song.new(attributes)}
  end

  def current_playlist_songs
    @mpc.current_playlist_songs.map{|attributes| Song.new(attributes) }
  end

  def list_playlists
    output = Array.new
    @mpc.list_playlists.each do |playlist|
      @p = Playlist.new(playlist[:playlist])
      @p.exists = true
      output << @p
    end
    output
  end

  def list_playlist_info(name)
    @mpc.list_playlist_info(name).map{|attributes| Song.new(attributes)}
  end

  def move_song(song, to)
   @mpc.move_song(song, to)
  end

  def seek(pos, song = nil)
    @mpc.seek(pos, song)
  end
end