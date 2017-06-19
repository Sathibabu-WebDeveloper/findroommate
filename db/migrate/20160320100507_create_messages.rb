class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :listing
      t.belongs_to :user
      t.belongs_to :admin
      t.string :name
      t.string :phoneno
      t.text :message
      t.boolean :status, default: false
      t.timestamps null: false
    end
  end
end
