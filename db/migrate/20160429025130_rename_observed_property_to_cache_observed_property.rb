class RenameObservedPropertyToCacheObservedProperty < ActiveRecord::Migration
  def change
    rename_table :observed_properties, :cache_observed_properties
  end
end
