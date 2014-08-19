class Review < ActiveRecord::Base
  
  belongs_to :movie


  validates :name, presence: true

  validates :comment, length: { minimum: 4 }

  STARS = [1, 2, 3, 4, 5]

  validates :stars, inclusion: { 
  	in: STARS,
  	message: "must be between 1 and 5"
  }

end

# Check that out! It already has a belongs_to declaration. 
# Rails figured this part out because we used movie:references 
# when generating the Review resource. 
# Notice that the belongs_to declaration references the singular form 
# of the parent (movie).