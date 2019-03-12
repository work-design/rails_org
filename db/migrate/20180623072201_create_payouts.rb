class CreatePayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :payouts do |t|
      t.string :type
      t.decimal :amount, precision: 10, scale: 2
      t.string :payout_uuid
      t.string :state
      t.string :to_bank
      t.string :to_name
      t.string :to_identifier
      t.datetime :paid_at
      t.timestamps
    end
  end
end
