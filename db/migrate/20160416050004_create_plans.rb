class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.float :price
      t.integer :duration
      t.string :duration_type
      t.text :description
      t.boolean :status ,defalut: false
      t.integer :limit
      t.timestamps null: false
    end
  end
end
