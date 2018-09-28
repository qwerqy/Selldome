class AddGuestNumberToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :guest_number, :integer
  end
end
