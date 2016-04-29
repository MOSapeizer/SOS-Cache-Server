class CreateObservedProperties < ActiveRecord::Migration
  def change
    create_table :observed_properties do |t|
      t.string :property
      t.timestamps null: false
    end
  end
end
