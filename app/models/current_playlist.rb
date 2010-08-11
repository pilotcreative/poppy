class CurrentPlaylist
  include Singleton
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :name

  validate do |name|
    errors.add_to_base("Name can't be blank") if @name.blank?
  end

  def songs
    Player.instance.current_playlist_songs
  end

  def save
     Player.instance.create_playlist(@name) if valid?
  end

  def add(path)
    Player.instance.add_to_playlist(path)
  end

  def clear!
    Player.instance.clear!
  end
end