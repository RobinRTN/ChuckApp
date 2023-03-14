class AddCoordinatesToFormules < ActiveRecord::Migration[7.0]
  def change
    add_column :formules, :address_line, :string
    add_column :formules, :address_city, :string
    add_column :formules, :latitude, :float
    add_column :formules, :longitude, :float
  end
end
