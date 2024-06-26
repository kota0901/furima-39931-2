class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code, null: false
      t.integer :region_id, null: false
      t.string :municipalities, null: false
      t.string :banchi, null: false
      t.string :building_name
      t.string :number, null: false
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
