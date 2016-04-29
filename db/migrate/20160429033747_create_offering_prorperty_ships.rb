class CreateOfferingProrpertyShips < ActiveRecord::Migration
  def change
    create_table :offering_prorperty_ships do |t|
      t.integer :cache_offering_id
      t.integer :cache_observed_property_id

      t.timestamps null: false
    end
  end
end
