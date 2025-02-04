class MoviesController < ApplicationController
  # Listar todos os filmes favoritos
  def index
    @movies = Movie.all
  end

  # Formulário para adicionar um novo filme
  def new
    @movie = Movie.new
  end

  # Adicionar um novo filme
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: 'Filme adicionado aos favoritos.'
    else
      render :new
    end
  end

  # Exibir detalhes do filme
  def show
    @movie = Movie.find(params[:id])
  end

  # Editar um filme
  def edit
    @movie = Movie.find(params[:id])
  end

  # Atualizar filme
  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Filme atualizado com sucesso.'
    else
      render :edit
    end
  end

  # Remover um filme
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: 'Filme removido dos favoritos.'
  end

  private

  # Permitir apenas os parâmetros seguros
  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :synopsis, :user_comment)
  end
end
