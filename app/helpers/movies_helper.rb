module MoviesHelper
 def format_total_gross(movie)
   if movie.flop?
    content_tag(:strong, 'Flop!')
   else
     number_to_currency(movie.total_gross)
   end
 end
 
 def image_for(movie)
   if movie.image_file_name.blank?
     image_tag('placeholder.png')
   else
     image_tag(movie.image_file_name)
   end
 end


=begin
  
Next we want to display the average number of stars on a movie's show page. 
That's easy enough, but there's a catch: if the movie doesn't have any reviews 
then the average_stars method will return nil. In that case, rather than just 
displaying a blank value we instead want to display "No reviews".

Hmm... so we have conditional view logic. And that always belongs in a view helper. 

Let's start from the outside-in and assume we have a format_average_stars helper 
that takes a movie object and applies the conditional logic. 

Define the format_average_stars method in the movies_helper.rb file. 
It needs to take a movie object as a parameter. 

=end

  def format_average_stars(movie)
    if movie.no_reviews?
      content_tag(:strong, 'No reviews')
    else
      "*" * movie.average_stars.round
    end
  end


end