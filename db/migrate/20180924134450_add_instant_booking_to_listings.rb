class AddInstantBookingToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :instant_booking, :boolean
  end
end
