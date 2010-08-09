class SongSearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion  
  include ActiveModel::Validations
  
  validates_presence_of :what
  validates_inclusion_of :type, :in => %w(artist title album filename)
  attr_accessor :type,:what

  def initialize(params = {})
    self.type = params[:type] ||= "dupa"
    self.what = params[:what] ||= nil
  end
  def persisted?
    false
  end

  def find
    Player.instance.find(self.type, self.what)
  end

end