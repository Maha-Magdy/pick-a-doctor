class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.references :specialization, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
