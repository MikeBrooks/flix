class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.integer :stars
      t.text :comment
      t.references :movie, index: true

      t.timestamps
    end
  end
end


=begin
	
Remember that migrations only get applied to the development database. 
At this point, the test database doesn't have the reviews table.

So this is a good time to get the test database in step with 
the development database. Otherwise, your specs will fail 
when you try to run them later.

rake db:test:prepare

# or for Rails 4.1
rake db:schema:load RAILS_ENV=test

=end