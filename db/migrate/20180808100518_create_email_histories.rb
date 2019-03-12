class CreateEmailHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :email_histories do |t|
      t.references :historyable, polymorphic: true
      t.string :from
      t.string :to
      t.string :cc
      t.string :subject
      t.text :body
      t.timestamps
    end
  end
end
