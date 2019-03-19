class RailsOrgInit < ActiveRecord::Migration[6.0]

  def change

    create_table :organs do |t|
      t.string :name
      t.string :organ_uuid
      t.timestamps
    end

    create_table :organ_grants do |t|
      t.references :organ
      t.references :member
      t.references :user
      t.string :token, null: false
      t.datetime :expired_at
      t.timestamps
    end

    create_table :offices do |t|
      t.references :organ
      t.references :area
      t.string :name
      t.string :address
      t.string :timezone
      t.string :locale
      t.integer :members_count, default: 0
      t.timestamps
    end

    create_table :rooms do |t|
      t.references :office
      t.string :room_number
      t.timestamps
    end

    create_table :departments do |t|
      t.references :organ
      t.references :parent
      t.references :leader
      t.string :name
      t.integer :members_count, default: 0
      t.integer :needed_member
      t.string :collective_email
      t.timestamps
    end

    create_table :department_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
      t.index [:ancestor_id, :descendant_id, :generations], unique: true, name: 'department_anc_desc_idx'
      t.index [:descendant_id], name: 'department_desc_idx'
    end

    create_table :members do |t|
      t.references :user
      t.references :department
      t.references :office
      t.references :organ
      t.string :type
      t.string :name
      t.string :email
      t.string :number
      t.date :join_on
      t.boolean :enabled, default: true
      t.string :state
      t.string :organ_grant
      t.timestamps
    end

  end

end
