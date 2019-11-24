class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.string :title
      t.string :description
      t.boolean :confirmed, default: false
      t.boolean :withdrawn, default: false

      t.timestamps
    end
  end
end
