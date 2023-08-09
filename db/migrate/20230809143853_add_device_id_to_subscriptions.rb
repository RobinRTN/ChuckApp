class AddDeviceIdToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :device_id, :string
  end
end
