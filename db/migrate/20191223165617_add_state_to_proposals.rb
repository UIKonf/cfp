class AddStateToProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :state, :string, default: 'draft'
  end
end
