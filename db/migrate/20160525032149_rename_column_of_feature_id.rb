class RenameColumnOfFeatureId < ActiveRecord::Migration
  def change
    rename_column :offering_feature_ships, :cache_feature_id, :feature_id
  end
end
