class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :offering
      t.string :procedure
      t.string :beginTime
      t.string :endTime
      t.timestamps null: false
    end
  end
end
