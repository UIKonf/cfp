class AddBlockedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :blocked, :bool, default: false
    add_column :users, :block_reason, :text, default: nil, null: true
  end
end
