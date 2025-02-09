class MoviesController < ApplicationController
  def index
    if current_user
      @movies = current_user.favorite_movies.page(params[:page]).per(20)
    else
      redirect_to new_user_session_path, alert: 'You need to be logged in to view your favorite movies.'
    end
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

  def search
    @movies = if params[:query].present?
                OmdbService.search_movies(params[:query])
              else
                []
              end
  end

  def add_comment
    @movie = Movie.find(params[:id])

    if params[:comment].present?
      @movie.add_comment(current_user, params[:comment])
      flash[:success] = 'Comment added successfully!'
    else
      flash[:error] = 'Comment cannot be empty.'
    end

    redirect_to movie_path(@movie)
  end

  def remove_comment
    @movie = Movie.find(params[:id])
    comment_id = params[:comment_id]
    comment = @movie.comments.find { |c| c['_id'].to_s == comment_id }

    if comment
      @movie.comments.delete(comment)
      @movie.save
      flash[:success] = 'Comment deleted successfully!'
    else
      flash[:error] = 'Comment not found.'
    end

    redirect_to movie_path(@movie)
  end

  def favorite
    movie_data = OmdbService.get_movie_details(params[:imdb_id])

    movie = Movie.find_or_create_by(imdb_id: movie_data['imdbID']) do |m|
      m.title = movie_data['Title']
      m.year = movie_data['Year']
      m.genre = movie_data['Genre']
      m.director = movie_data['Director']
      m.synopsis = movie_data['Plot']
      m.poster = movie_data['Poster']
    end

    current_user.favorite_movies << movie unless current_user.favorite_movies.include?(movie)

    redirect_to movies_path, notice: 'Filme adicionado aos favoritos.'
  end

  def favorites
    @movies = current_user.favorite_movies
  end

  def unfavorite
    movie = Movie.find(params[:id])

    if current_user.favorite_movies.include?(movie)
      current_user.favorite_movies.delete(movie)
      flash[:notice] = 'Filme removido dos favoritos.'
    else
      flash[:alert] = 'Filme não encontrado nos favoritos.'
    end

    redirect_to movies_path
  end

  def edit_comment
    @movie = Movie.find(params[:id])
    @comment = @movie.comments.find { |c| c['_id'].to_s == params[:comment_id] }

    return unless @comment.nil?

    redirect_to movie_path(@movie), alert: 'Comentário não encontrado.'
  end

  def update_comment
    @movie = Movie.find(params[:id])
    @comment = @movie.comments.find { |c| c['_id'].to_s == params[:comment_id] }

    if @comment.nil?
      redirect_to movie_path(@movie), alert: 'Comentário não encontrado.'
    else
      @comment['content'] = params[:content]

      if @movie.save
        redirect_to movie_path(@movie), notice: 'Comentário atualizado com sucesso!'
      else
        redirect_to movie_path(@movie), alert: 'Erro ao atualizar o comentário.'
      end
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :synopsis, :user_comment)
  end
end
