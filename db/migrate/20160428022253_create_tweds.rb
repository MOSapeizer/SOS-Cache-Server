class CreateTweds < ActiveRecord::Migration
  def change
    create_table :tweds do |t|
      t.string :offering
      t.string :procedure
      t.string :phnomenonTime
      t.string :result
      t.timestamps null: false
    end
  end
end
