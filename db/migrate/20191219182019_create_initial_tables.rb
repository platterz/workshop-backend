# frozen_string_literal: true

class CreateInitialTables < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :price_range
      t.string :description
      t.string :image
      t.string :image_description

      t.timestamps null: false, default: -> { 'now()' }
    end

    create_table :restaurant_products do |t|
      t.string :item, null: false
      t.float :price, null: false
      t.references :restaurants, index: true, foreign_key: true, null: false
      t.timestamps null: false, default: -> { 'now()' }
    end
  end
end
