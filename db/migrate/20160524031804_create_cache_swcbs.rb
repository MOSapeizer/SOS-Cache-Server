class CreateCacheSwcbs < ActiveRecord::Migration
  def change
    create_table :cache_swcbs do |t|

      t.timestamps null: false
    end
  end
end
