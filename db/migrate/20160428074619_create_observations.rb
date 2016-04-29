class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.string :phenomenonTime
      t.string :result
      t.timestamps null: false
    end
  end
end
