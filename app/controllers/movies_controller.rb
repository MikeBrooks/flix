class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
    @review = Review.new
    @review.movie_id = @movie.id
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      # flash[:notice] = "Movie successfully updated!"
      # Finally, setting notice flashes is so common that Rails provides 
      # a shortcut. You can pass an option to redirect_to to automatically 
      # set the appropriate flash before the redirection happens. 
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!" 
    else
      render :new
    end
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!" 
    # redirect_to movies_url, danger: "I'm sorry, I'm afraid I can't do that!"
  end
  
private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name)
  end
end

