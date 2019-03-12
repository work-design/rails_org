class CreateHrCheckSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :check_settings do |t|
      t.references :checking, polymorphic: true
      t.string :code
      t.integer :position
      t.timestamps
    end

    rename_table :crm_permits, :supports
    add_reference :supports, :supporter
    drop_table :crm_performs
  end
end
