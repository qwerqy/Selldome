class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :place_type
      t.string :property_type

      t.integer :room_number
      t.integer :bathroom_number
      t.integer :guest_number

      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :address

      t.decimal :price
      t.string :description

      t.boolean :verified, default: false

      t.references :user

      t.timestamps null: false
    end
  end
end
