class AddPackageToFormules < ActiveRecord::Migration[7.0]
  def change
    add_reference :formules, :package, foreign_key: true, null: true
  end
end
