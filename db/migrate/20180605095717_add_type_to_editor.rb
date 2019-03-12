class AddTypeToEditor < ActiveRecord::Migration[5.2]
  def change
    add_column :editors, :type, :string


    create_table :badges do |t|
      t.string :title
      t.string :abbr
      t.string :level
      t.timestamps
    end

    create_table :editor_badges do |t|
      t.references :editor
      t.references :badge
      t.date :awarded_on
      t.timestamps
    end

    remove_column :members, :badges

  end
end
