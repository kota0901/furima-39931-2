class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string     :item_name,               null: false
      t.integer    :category_id,             null: false
      t.integer    :situation_id,            null: false
      t.integer    :delivery_fee_payment_id, null: false
      t.integer    :region_id,               null: false
      t.integer    :deadline_id,             null: false
      t.integer    :price,                   null: false
      t.text       :item_text,               null: false
      t.references :user,                    null: false, foreign_key: true
      t.timestamps
    end
  end
end
