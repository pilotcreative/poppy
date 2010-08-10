class SongSearchesController < ApplicationController
  before_filter :get_select_types
  def new
    @search = SongSearch.new
  end

  def create
    @search = SongSearch.new(params[:song_search])
    if @search.valid?
      @results = @search.find
      render :layout=>nil
    else
      render :text => "Error"
    end
  end
  private
  def get_select_types
    @select_types = ["artist", "title", "album", "filename"]
  end
end