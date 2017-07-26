class CreateFibs < ActiveRecord::Migration[5.1]
  def change
    create_table :fibs do |t|
      t.text :fibs, default: "", null: false
      t.integer :space, default: 0

      t.timestamps
    end
  end
end
