class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :apartment, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
