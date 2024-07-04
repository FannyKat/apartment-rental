class CreateApartments < ActiveRecord::Migration[7.1]
  def change
    create_table :apartments do |t|
      t.references :owner,  null: false, foreign_key: { to_table: :users }

      t.string  :location,  null: false, default: ""
      t.string  :title,     null: false, default: ""
      t.text    :amenities, null: false, default: ""

      t.integer :number_of_bedrooms, null: false, default: 0

      t.integer :rent_amount, null: false, default: 0

      t.timestamps
    end
  end
end
