class AddSquaresToFibs < ActiveRecord::Migration[5.1]
  def change
    add_column :fibs, :squares, :integer
  end
end
