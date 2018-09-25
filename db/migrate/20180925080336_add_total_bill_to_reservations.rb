class AddTotalBillToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :total_bill, :integer
  end
end
