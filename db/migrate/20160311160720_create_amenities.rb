class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :name
      t.string :icon_name
      t.timestamps null: false
    end
  end
end
