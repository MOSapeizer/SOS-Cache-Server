class RenameCacheOfferingObservedPropertyToReverse < ActiveRecord::Migration
  def change
    rename_table :cache_offerings_observed_properties, :cache_observed_properties_offerings
  end
end
