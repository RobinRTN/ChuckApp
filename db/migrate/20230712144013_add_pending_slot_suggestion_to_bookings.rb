class AddPendingSlotSuggestionToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :pending_slot_suggestion, :boolean, default: false
  end
end
