class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.references :checking, polymorphic: true
      t.references :member
      t.string :comment
      t.boolean :approved
      t.integer :position
      t.string :state
      t.timestamps
    end
  end
end
