class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :connect_to_player
  private
  def connect_to_player
    @player = Player.new("object_reload")
  end
end
