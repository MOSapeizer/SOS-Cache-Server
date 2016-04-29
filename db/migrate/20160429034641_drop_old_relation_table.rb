class DropOldRelationTable < ActiveRecord::Migration
  def change
    drop_table :cache_observed_properties_offerings
  end
end
