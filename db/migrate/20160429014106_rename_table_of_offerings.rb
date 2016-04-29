class RenameTableOfOfferings < ActiveRecord::Migration
  def change
    rename_table :cacheOfferings, :cache_offerings
    rename_table :cacheTweds, :cache_tweds
  end
end
