class CreateOfferingFeatureShips < ActiveRecord::Migration
  def change
    create_table :offering_feature_ships do |t|
      t.integer :cache_offering_id
      t.integer :cache_feature_id

      t.timestamps null: false
    end
  end
end
