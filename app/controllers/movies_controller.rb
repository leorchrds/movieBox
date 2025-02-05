class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: 'Filme adicionado aos favoritos.'
    else
      render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Filme atualizado com sucesso.'
    else
      render :edit
    end
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: 'Filme removido dos favoritos.'
  end

  # Buscar filmes usando a API OMDb
  def search
    if params[:query].present?
      @movies = OmdbService.search_movies(params[:query])
    else
      @movies = []
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :synopsis, :user_comment)
  end
end
