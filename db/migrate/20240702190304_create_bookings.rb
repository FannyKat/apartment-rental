class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :tenant,     null: false, foreign_key: { to_table: :users }
      t.references :apartment,  null: false, foreign_key: true

      t.string  :status,  null: false, default: "pending"

      t.text    :message, null: false, default: ""

      t.datetime  :start_date,  precision: nil
      t.datetime  :end_date,    precision: nil

      t.timestamps
    end
  end
end
