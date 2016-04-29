class RenameObservedPropertyColumnOfRelationTable < ActiveRecord::Migration
  def change
    rename_column :cache_offerings_observed_properties, :observed_property_id, :cache_observed_property_id
  end
end
