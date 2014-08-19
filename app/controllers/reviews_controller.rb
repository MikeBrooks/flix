class ReviewsController < ApplicationController

	# We always want to run the set_movie method before running any action's code. 
	# To do that, use before_action to make sure the method is called before any 
	# action's code is executed. 

	# Call the before_action method and pass it the name of the method you want 
	# to run (as a symbol).

	# Since a review only makes sense in the context of an movie, the first thing every action 
	# does is look up the movie using identical code: 
	
=begin
	
Using a before_action is an idiomatic way to remove duplication in a controller, 
but you can also use before_action to share common functionality across controllers. 

For example, 
- if you had a before_action in the ApplicationController class it would get applied 
to every action in your application. 
- Alternatively, you could define a common method in the ApplicationController and then 
selectively apply it to specific controllers by adding the before_action line to each 
participating controller. 
- Finally, you can use the :only and :except options to apply the before_action to 
specific actions within a controller. 
	
=end

	before_action :set_movie

	def index
		# @movie = Movie.find(params[:movie_id])
		@reviews = @movie.reviews
	end

	def new
		# @movie = Movie.find(params[:movie_id])
		@review = @movie.reviews.new
	end

	def create
		# @movie = Movie.find(params[:movie_id])
		@review = @movie.reviews.new(review_params)
		if @review.save
			redirect_to movie_reviews_path(@movie),
				notice: "Thanks for your review!"
		else
			render :new
		end
	end

  def destroy
  	# @movie = Movie.find(params[:movie_id])
  	@review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_url(@movie), notice: "Review successfully deleted!" 
  end

	def edit
		# @movie = Movie.find(params[:movie_id])
		@review = @movie.reviews.find(params[:id])
	end

	def update
		# @movie = Movie.find(params[:movie_id])
		@review = @movie.reviews.find(params[:id])

		if @review.update(review_params)
			redirect_to movie_reviews_path(@movie), notice: "Review successfully updated!"
		else
			render :edit
		end
	end


	private
	# Note that methods that are public (the default access control) are callable as actions. 
	# Our set_movie method is only going to be called within the controller, so it's good form 
	# to make the method private. That way it can't be called as an action. 
	
	# Since a review only makes sense in the context of an movie, the first thing every action 
	# does is look up the movie using identical code: 
	def set_movie
		@movie = Movie.find(params[:movie_id])
	end

	def review_params
		params.require(:review).permit(:name, :location, :stars, :comment)
	end

end
