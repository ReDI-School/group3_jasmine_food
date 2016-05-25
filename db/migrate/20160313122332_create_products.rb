class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :titel
      t.text :description
      t.string :image_url
      t.decimal :price

      t.timestamps null: false
    end
  end
end
