class AddFiledsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :image_url, :string, default: :null
    add_column :listings, :up_votes, :integer, default: :null
    add_column :listings, :down_votes, :integer, default: :null
    add_column :listings, :avgrating, :integer, default: :null
    add_column :listings, :views, :integer, default: :null
    add_column :listings, :time_ago, :string, default: :null
  end
end
