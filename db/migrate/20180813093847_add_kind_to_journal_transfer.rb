class AddKindToJournalTransfer < ActiveRecord::Migration[5.2]
  def change
    add_reference :journal_transfers, :member
  end
end
