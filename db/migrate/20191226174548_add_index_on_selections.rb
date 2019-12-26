class AddIndexOnSelections < ActiveRecord::Migration[6.0]
  def change
    add_index :selections, %i[user_id proposal_id], unique: true
  end
end
