class AddSynchroParamsToSyncAudit < ActiveRecord::Migration[5.2]
  def change
    add_column :sync_audits, :synchro_params, :string
    remove_columns :sync_audits, :synchro_primary_key, :synchro_primary_value
  end
end
