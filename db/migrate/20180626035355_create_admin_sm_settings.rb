class CreateAdminSmSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :sm_settings do |t|
      t.string :access_token
      t.datetime :limit_at
      t.boolean :working
      t.timestamps
    end
  end
end
