class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :location
      t.decimal :price
      t.string :description
      t.string :size
      t.string :property_type
      t.references :user

      t.timestamps null: false
    end
  end
end
