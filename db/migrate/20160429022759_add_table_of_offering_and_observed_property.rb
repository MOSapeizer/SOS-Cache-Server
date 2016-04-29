class AddTableOfOfferingAndObservedProperty < ActiveRecord::Migration
  def change
    create_table :cache_offerings_observed_properties do |t|
      t.belongs_to :cache_offering
      t.belongs_to :observed_property
    end
  end
end
