class AddPriceToPackages < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :price, :float
    add_column :packages, :frequence, :float
  end
end
