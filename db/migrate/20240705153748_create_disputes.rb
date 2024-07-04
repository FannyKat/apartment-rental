class CreateDisputes < ActiveRecord::Migration[7.1]
  def change
    create_table :disputes do |t|
      t.references :booking,  null: false, foreign_key: true
      t.references :user,     null: false, foreign_key: true

      t.text :description,    null: false, default: ""
      t.string :status,       null: false, default: ""

      t.timestamps
    end
  end
end
