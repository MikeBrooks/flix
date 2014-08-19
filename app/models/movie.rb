class Movie < ActiveRecord::Base
  
  validates :title, :released_on, :duration, presence: true

  validates :description, length: {minimum: 25}

  validates :total_gross, numericality: {greater_than_or_equal_to: 0}

  validates :image_file_name, allow_blank: true, format: {
  with:    /\w+.(gif|jpg|png)\z/i,
  message: "must reference a GIF, JPG, or PNG image"
  }

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :rating, inclusion: {in: RATINGS}


  # declaring one-to-many relationship
  has_many :reviews, dependent: :destroy
  # This declaration tells Rails to expect a movie_id foreign key column 
  # in the table wrapped by the Review model, 
  # which by convention will be the reviews table. 
  # Rails also dynamically defines methods for accessing a movie's related 
  # reviews. 
=begin
 Then ask the movie for its reviews.

  When you declared has_many :reviews in the Movie model, 
  Rails dynamically defined a reviews instance method. 
  Calling that method on a Movie object returns an array of Review objects 
  for that particular movie. If the movie doesn't have any reviews, 
  the array will be empty.
=end
  def self.released

    where("released_on <= ?", Time.now).order("released_on desc")
  end
  
  def self.hits
    where('total_gross >= 300000000').order('total_gross desc')
  end
  
  def self.flops
    where('total_gross < 10000000').order('total_gross asc')
  end
  
  def self.recently_added
    order('created_at desc').limit(3)
  end
  
  def flop?
    total_gross.blank? || total_gross < 50000000 unless (count_reviews >= 5 && average_stars.round >= 4)
  end
      


  # You'll call the same calculation method you used earlier in the console, 
  # but because you're inside of an instance method you don't need to use the movie object. 
  # The current object (self) will already be set to a movie object 
  # and it becomes the implicit receiver of the call to reviews.
  def average_stars
    reviews.average(:stars)
  end

  # Just like zero? or blank?, you can use the nil? method to test if a value is nil.
  def no_reviews?
    average_stars.nil?
    # or my version that works as well:
    # reviews.size.nil?
  end

  def recent_reviews
    reviews.order(created_at: :desc).limit(2)
  end

  def count_reviews
    reviews.count
  end

end
