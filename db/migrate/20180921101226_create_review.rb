class CreateReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating, index: true
      t.string :comment, index: true
      t.belongs_to :user
      t.belongs_to :listing

      t.timestamps
    end
  end
end
