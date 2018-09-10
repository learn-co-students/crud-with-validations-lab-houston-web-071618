class SongsController < ApplicationController
    def index
        @songs = Song.all
    end

    def create
        sp = params.require(:song)
        sp[:release_year] = sp[:release_year].to_i
        # ActionController::Parameters.permit_all_parameters = true
        # @song = Song.new({title: sp[:title], released: sp[:released], release_year: sp[:release_year].to_i, artist_name: sp[:artist_name], genre: sp[:genre]})
        sp = sp.to_unsafe_hash
        @song = Song.create(sp)
        # binding.pry
        if @song.errors.messages.length == 0
            redirect_to song_path(@song)
        else
            render :new
        end
    end

    def new
        @song = Song.new()
    end

    def edit
        @song = Song.find(params[:id])
    end

    def show
        @song = Song.find(params[:id])
    end

    def update
        @song = Song.find(params[:id])
        sp = params.require(:song)
        sp[:release_year] = sp["release_year"].to_i
        sp = sp.to_unsafe_hash
        @song.update(sp)
        if !@song.errors.any?
            redirect_to song_path(@song)
        else
            render :edit
        end
    end

    def destroy
        @song = Song.find(params[:id])
        @song.destroy
        redirect_to songs_path
    end


end
