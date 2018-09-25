class AddPaidToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :paid, :boolean
  end
end
