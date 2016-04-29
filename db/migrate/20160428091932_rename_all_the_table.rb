class RenameAllTheTable < ActiveRecord::Migration
  def change
  	rename_table :offerings, :cacheOfferings
  	rename_table :tweds, :cacheTweds
  end
end
