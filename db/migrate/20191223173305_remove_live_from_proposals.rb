class RemoveLiveFromProposals < ActiveRecord::Migration[6.0]
  def change
    remove_column :proposals, :live
  end
end
