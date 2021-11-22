require 'rspotify'

class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.valid?
      @playlist.spotify_id = PlaylistCreator.new(@playlist.genre, @playlist.energy, @playlist.danceability, @playlist).get_playlist
    end

    if @playlist.save
      redirect_to playlist_path(@playlist)
    else
      render :new
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :genre, :danceability, :energy, :spotify_id)
  end

end
