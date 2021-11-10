class PlaylistsController < ApplicationController

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to playlist_path(@playlist)
    else
      render :new
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :genre, :danceability, :energy)
  end
end