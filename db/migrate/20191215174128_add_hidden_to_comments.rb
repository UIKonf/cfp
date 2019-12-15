class AddHiddenToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :hidden, :bool, default: false
  end
end
