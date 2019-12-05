class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.references :bearer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :stocks, :name, unique: true
  end
end
