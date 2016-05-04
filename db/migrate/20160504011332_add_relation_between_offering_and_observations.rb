class AddRelationBetweenOfferingAndObservations < ActiveRecord::Migration
  def change
    add_column :observations, :cache_offering_id, :integer
  end
end
