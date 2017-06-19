class ListingsAndRules < ActiveRecord::Migration
  def change
  	 create_table  :listings_rules, id: false do |t|
      t.belongs_to :listing, index: true
      t.belongs_to :rule, index: true
    end
  end
end
