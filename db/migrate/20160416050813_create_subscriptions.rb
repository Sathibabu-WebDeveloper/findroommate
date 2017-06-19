class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :plan, index: true
      t.belongs_to :user
      t.string :email    
      t.timestamps null: false
    end
  end
end
