class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.string :name
      t.string :subject
      t.text :body
      t.string :category
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
