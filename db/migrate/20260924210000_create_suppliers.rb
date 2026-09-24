class CreateSuppliers < ActiveRecord::Migration[8.1]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.string :contact_name
      t.string :email
      t.string :phone
      t.string :delivery_days
      t.integer :lead_time_days, null: false, default: 1
      t.text :notes

      t.timestamps
    end
  end
end
