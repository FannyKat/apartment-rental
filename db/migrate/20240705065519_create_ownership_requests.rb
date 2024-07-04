class CreateOwnershipRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :ownership_requests do |t|
      t.references :tenant, null: false, foreign_key: { to_table: :users }

      t.string  :status,      null: false, default: "pending"
      t.string  :email,       null: false, default: ""
      t.string  :first_name,  null: false, default: ""
      t.string  :last_name,   null: false, default: ""

      t.timestamps
    end
  end
end
