class AddStockLevelToProduct < ActiveRecord::Migration
  def change
    add_column :products, :stock_level, :integer
  end
end
