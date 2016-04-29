class AddTypeToOffering < ActiveRecord::Migration
  def change
  	add_column :offerings, :type, :string
  end
end
