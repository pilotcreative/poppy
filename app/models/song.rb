class Song
  include ActiveModel::AttributeMethods
  extend ActiveModel::Naming

  attr_reader :attributes
  attribute_method_suffix ""
  attribute_method_suffix "="

  define_attribute_methods [:artist, :title, :time, :date, :album, :genre, :file]

  def initialize(attributes)
    @attributes = attributes.with_indifferent_access
  end

  def self.find(type, what = "")
    Player.instance.find(type, what)
  end

  def self.find_by_artist(what)
    self.find("artist", what)
  end

  def self.find_by_title(what)
    self.find("artist", what)
  end

  def self.find_by_album(what)
    self.find("album",what)
  end

  def self.find_by_file(what)
    self.find("filename",what)
  end

  def self.all
    Player.instance.songs
  end

  def self.current
    Player.instance.current_song
  end

  protected

  def attribute(name)
    @attributes[name]
  end

  def attribute=(name, value)
    @attributes[name] = value
  end
end
