class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :pincode
      t.string :latitude
      t.string :longitude
      t.belongs_to :city, index: true
      t.timestamps null: false
    end
  end
end
