class AddVerifierIdToFinancial < ActiveRecord::Migration[5.2]
  def change
    add_reference :financial_taxons, :verifier
  end
end
