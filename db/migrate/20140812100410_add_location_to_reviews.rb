class AddLocationToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :location, :string, default: "unspecified"
  end
end
