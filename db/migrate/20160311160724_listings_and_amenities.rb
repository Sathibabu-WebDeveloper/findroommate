class ListingsAndAmenities < ActiveRecord::Migration
  def change
  	create_table  :amenities_listings, id: false do |t|
      t.belongs_to :listing, index: true
      t.belongs_to :amenity, index: true
    end
  end
end
