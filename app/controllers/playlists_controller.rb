require 'rspotify'

class PlaylistsController < AuthenticatedUserController

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
      @playlist.spotify_id = PlaylistCreator.new(@playlist).generate_from_seeds
    end

    if @playlist.save
      redirect_to playlist_path(@playlist)
    else
      render :new
    end
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    if @playlist.destroy
      PlaylistDestructor.new(@playlist).perform
    end
    redirect_to playlists_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :genre, :danceability, :energy, :spotify_id).merge(user: current_user)
  end

end
