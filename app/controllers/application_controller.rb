class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

=begin 
  By default, Rails supports setting the :notice and :alert flash types when 
  calling the redirect_to method. But sometimes you want to conveniently set 
  a custom flash type when redirecting. 

  For example, suppose you wanted to set a :danger flash type

	To do that, you'll need to register the :danger flash type:

  Add the following line inside of the ApplicationController class, 
  which is defined in the app/controllers/application_controller.rb file: 
=end
  add_flash_types(:danger)
=begin
	The ApplicationController is the base (parent) class that all other 
	controllers inherit from (subclass), so anything you put in here applies 
	to all controllers.
=end
	
end
