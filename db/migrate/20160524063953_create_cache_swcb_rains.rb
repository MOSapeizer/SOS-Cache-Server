class CreateCacheSwcbRains < ActiveRecord::Migration
  def change
    create_table :cache_swcb_rains do |t|

      t.timestamps null: false
    end
  end
end
