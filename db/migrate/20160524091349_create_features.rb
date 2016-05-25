class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
