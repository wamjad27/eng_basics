class CreateFibs < ActiveRecord::Migration[5.1]
  def change
    create_table :fibs do |t|
      t.integer :max_number
      t.string :sequence

      t.timestamps
    end
  end
end
