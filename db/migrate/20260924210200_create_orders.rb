class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :reference, null: false
      t.references :supplier, null: false, foreign_key: true
      t.string :status, null: false, default: "draft"
      t.date :expected_on
      t.integer :line_count, null: false, default: 0
      t.integer :total_cents, null: false, default: 0

      t.timestamps
    end
    add_index :orders, :reference, unique: true
  end
end
