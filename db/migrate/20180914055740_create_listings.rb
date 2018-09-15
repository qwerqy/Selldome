class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :place_type
      t.string :property_type

      t.string :room_number
      t.string :bathroom_number
      t.string :guest_number

      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :address

      t.decimal :price
      t.string :description
      
      t.references :user

      t.timestamps null: false
    end
  end
end
