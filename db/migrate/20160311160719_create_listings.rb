class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :room_type
      t.string :bedrooms
      t.string :rent
      t.string :rooms_for_rent
      t.string :available_from
      t.string :minimumstay
      t.string :current_roommates
      t.string :prefred_gender
      t.string :prefred_age
      t.string :prefred_occupation
      t.string :landmark      
      t.boolean :phonenumber_visibility
      t.string :security_deposit
      t.string :furnishing_status
      t.boolean :visible_status, default: false
      t.boolean :featured, default: false
      t.boolean :verified_status, default: false
      t.boolean :status, default: false
      t.belongs_to :user, index: true
      t.belongs_to :admin, index: true
      t.belongs_to :city, index: true
      t.belongs_to :area, index: true
      t.timestamps null: false
    end
  end
end
