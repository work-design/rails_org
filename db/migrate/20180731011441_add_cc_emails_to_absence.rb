class AddCcEmailsToAbsence < ActiveRecord::Migration[5.2]

  def change
    add_column :absences, :cc_emails, :string
    add_column :overtimes, :cc_emails, :string
  end

end
