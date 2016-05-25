class AddColumnProviderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :provider, :string
  end
end
