class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.string :location, null: false
      t.string :unit, null: false
      t.decimal :quantity, precision: 8, scale: 2, null: false, default: 0
      t.decimal :par_level, precision: 8, scale: 2, null: false, default: 0
      t.integer :unit_cost_cents, null: false, default: 0
      t.references :supplier, foreign_key: true
      t.text :notes

      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end
