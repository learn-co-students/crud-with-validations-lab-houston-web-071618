require 'pry'

class SongsController < ApplicationController
  # before_action :find_or_create_song
  
  def index
    @songs = Song.all
  end
  
  def new
    @song = Song.new
  end
  
  def create
    @song = Song.create(song_params)
    
    if @song.save
      redirect_to @song
    else
      render :new
    end 
    
  end
  
  def show
    @song = Song.find(params[:id])
  end
  
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    
    redirect_to songs_url
  end
  
  def edit
    @song = Song.find(params[:id])
  end
  
  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to @song
    else 
      render :edit 
    end
  end
  
  private
    def song_params
      params.require(:song).permit(:title, :artist_name, :release_year, :genre, :released)
    end
  
  # def find_or_create_song
  #   if Song.find(params[:id]).exists?
  #     @song = Song.find(params[:id])
  #   else 
  #     @song = Song.new
  #   end
  # end
end