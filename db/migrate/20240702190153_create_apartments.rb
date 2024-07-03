class CreateApartments < ActiveRecord::Migration[7.1]
  def change
    create_table :apartments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.decimal :rent_amount
      t.integer :number_of_bedrooms
      t.text :amenities

      t.timestamps
    end
  end
end
