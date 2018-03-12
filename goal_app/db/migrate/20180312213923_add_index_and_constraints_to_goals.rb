class AddIndexAndConstraintsToGoals < ActiveRecord::Migration[5.1]
  def change
    add_index :goals, :user_id
    change_column :goals, :description, :string, null: false
    change_column :goals, :user_id, :integer, null: false
  end
end
