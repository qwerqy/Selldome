class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :listing, index: true
      t.references :user, index: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
