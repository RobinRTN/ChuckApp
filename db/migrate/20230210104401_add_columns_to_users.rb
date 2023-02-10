class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, default: "coach"
    add_column :users, :payment_IBAN, :string
    add_column :users, :payment_BIC, :string
    add_column :users, :billing_address_line1, :string
    add_column :users, :billing_address_line2, :string
    add_column :users, :billing_zip_code, :string
    add_column :users, :billing_city, :string
    add_column :users, :billing_country, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :hourly_rate, :float
  end
end
