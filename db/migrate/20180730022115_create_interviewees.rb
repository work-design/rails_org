class CreateInterviewees < ActiveRecord::Migration[5.2]
  def change
    create_table :interviewees do |t|
      t.belongs_to :department, index: true
      t.belongs_to :office, index: true
      t.belongs_to :member, index: true
      t.string :name
      t.string :chinese_name
      t.string :gender
      t.string :contact
      t.string :email
      t.string :private_email
      t.string :university
      t.string :major
      t.string :degree
      t.datetime :interview_time
      t.string :interview_status
      t.datetime :training_begin
      t.date :join_date
      t.text :note
      t.string :position
      t.string :channel
      t.string :state
      t.timestamps
    end
  end
end
