class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :email
      t.string :name
      t.string :payment_IBAN
      t.string :payment_BIC
      t.string :billing_address_line1
      t.string :billing_address_line2
      t.string :billing_zip_code
      t.string :billing_city
      t.string :billing_country
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
