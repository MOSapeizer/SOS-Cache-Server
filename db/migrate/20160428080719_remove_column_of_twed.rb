class RemoveColumnOfTwed < ActiveRecord::Migration
  def change
  	remove_columns :tweds, :offering, :procedure, :phnomenonTime, :result
  end
end
