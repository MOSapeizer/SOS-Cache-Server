class RenameCacheObservedPropertyToObservedProperty < ActiveRecord::Migration
  def change
    rename_table :cache_observed_properties, :observed_properties
    rename_column :offering_prorperty_ships, :cache_observed_property_id, :observed_property_id
  end
end
