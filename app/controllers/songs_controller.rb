class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    current_song
  end

  def new
    @new_song = Song.new
  end

  def create
    @new_song = Song.new(song_params)
    # binding.pry
    if @new_song.valid?
      @new_song.save
      # binding.pry
      redirect_to song_path(@new_song)
    else
      # binding.pry
      render :new
    end
  end

  def edit
    # @song = Song.find(params[:id])
    @current = current_song
  end

  def update
    c = current_song
    c.assign_attributes(song_params)
    if c.valid?
      c.save
      redirect_to song_path(c)
    else
      render :edit
    end
  end

  def destroy
    current_song.destroy
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
  end

  def current_song
    @song = Song.find(params[:id])
  end
end
