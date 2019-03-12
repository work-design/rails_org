class AddVerifierIdToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :verifier
  end
end
