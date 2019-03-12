class AddSenderToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :sender, polymorphic: true
  end
end
